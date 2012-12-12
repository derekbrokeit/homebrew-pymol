brew-pymol
==========

Install pymol with home-brew.

    # make sure that brew is up to date
    brew update

    # tap this repo
    brew tap scicalculator/brew-pymol

    # install pymol
    brew install --HEAD pymol

## Incomplete

Currently this brew is incomplete. Pymol instalation of the stable branch 
results in a pymol library that breaks, so I have disabled it for the time being.
That's why you have to install from the head/trunk of the pymol repository.

Another problem is that the pmw toolbar does not yet seem to work. I haven't
figured out how to get the toolbar to work with this installation. It probably
has to do with not compiling the toolbar code on OSX, but at least you can get
pymol to run the main window. You can still use `load blah.pdb` or `run script.py` 
without problems.

If you can figure out these problems before me feel free to add to this repo. If we
can fix the need for `--HEAD` and get a working toolbar, this should be good for the
main homebrew repository.

