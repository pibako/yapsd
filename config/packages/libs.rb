# This is the place where you should specify libraries needed by your gems.

package :libs do
  description 'Dependencies for gems installed by app using bundler'

  requires :nokogiri_dep
end


package :nokogiri_dep do
  apt %w[libxml2-dev libxslt1-dev]

  verify do
    has_apt "libxml2-dev libxslt1-dev"
  end
end
