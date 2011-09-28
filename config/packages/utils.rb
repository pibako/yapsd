package :utils do
  requires :locale
  recommends :emacs
end

package :locale do
  description 'Sets your locale to en_US.UTF-8 UTF-8'
  en = "en_US.UTF-8"
  locale = "LANG=#{en}"
  locale_gen = "#{en} UTF-8"

  # this is a workaround to the problem with sudo and push_text
  push_text locale, "/tmp/locale" do
    pre :install, "rm /etc/default/locale"
    post :install, "mv /tmp/locale /etc/default/locale"
    post :install, "chmod 644 /etc/default/locale"
  end

  push_text locale_gen, "/tmp/locale.gen" do
    pre :install, "mv /etc/locale.gen /tmp/locale.gen"
    pre :install, "chmod a+w /tmp/locale.gen"
    post :install, "mv /tmp/locale.gen /etc/locale.gen"
    post :install, "chmod 644 /etc/locale.gen"
    post :install, "locale-gen"
  end

  # how to verify it?
  verify do
    file_contains "/etc/default/locale", locale
  end
end

package :emacs do
  apt 'emacs23-nox'

  emacs_dot_file = File.join(File.dirname(__FILE__), 'emacs', 'emacs')
  push_text File.read(emacs_dot_file), "~/.emacs"

  verify do
    has_apt 'emacs23-nox'
    has_file "~/.emacs"
  end
end
