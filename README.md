homebrew-pymol
==========

Install Pymol with [Homebrew][hb].

    # make sure that brew is up to date
    brew update

    # tap this repo
    brew tap scicalculator/pymol

    # install pymol
    brew install --HEAD pymol

**Requirements:** It's not specified in the brew file, but this requires
the latest available XQuartz (at least 2.7.2, which came with freeglut)
build of X11.

## Incomplete

Currently this brew is incomplete. Pymol installation of the stable
branch results in a Pymol library that breaks, so I have disabled it for
the time being. That's why you have to install from the head/trunk of
the Pymol repository.

The *main GUI* works without problems, but the "external GUI" does
not yet work. I haven't figured out how to get the "external GUI" to
load on launch. That means there is no "file" menu or most of the
mouse-friendly menus the external-gui provided. That being said, *the
sidebar and anything incorporated into the main gui is available*.
You can still use the main gui with it's built in terminal and
molecular/crystal/whataver-you-like viewer i.e. `load blah.pdb` or `run
script.py` work without problems.

If you can figure out these problems before me feel free to add to
this repo. If we can fix the need for `--HEAD` and get a working
"external GUI", this should be good for incorporation into the
[Homebrew/science][hbsci] repository.

[hb]:http://mxcl.github.com/homebrew/
[hbsci]:https://github.com/Homebrew/homebrew-science
