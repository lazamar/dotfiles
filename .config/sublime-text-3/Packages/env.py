# Save this file
#   mac   - "~/Library/Application Support/Sublime Text 3/Packages/"
#   linux - "~/.config/sublime-text-3/Packages/"

# NOTE!
#   ~/.nvm/alias/default must contain full version name.
#   $ nvm alias default v4.3.5

import os

home = os.environ['HOME']
with open("%s/.nvm/alias/default" % home) as nvm_default_file:
	nvm_default_contents = nvm_default_file.read().strip()
	path = "%s/.nvm/versions/node/%s/bin" % (home, nvm_default_contents)
	path = path + ":" + os.environ['PATH']
	os.environ['PATH'] = path
