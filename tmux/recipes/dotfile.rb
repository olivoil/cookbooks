#
# Copyright 2012, Olivier Melcher
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

node['etc']['passwd'].each do |user, data|
  # only do this for non-system users
  if data['uid'].to_i >= 1000 and user != 'nobody'

    home_dir = data['home'] || data['dir'] || "/home/#{data['id']}"

    cookbook_file "#{home_dir}/.dotfiles/tmux.conf" do
      source "tmux.conf"
      owner user
      group data['gid']
      mode 0644
    end

    link "#{home_dir}/.tmux.conf" do
      to "#{home_dir}/.dotfiles/tmux.conf"
    end
  end
end

cookbook_file "/usr/local/bin/tmx" do
  source "tmx"
  mode 0755
end
