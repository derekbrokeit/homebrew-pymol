homebrew-pymol
==========

The simplest way to install [Pymol][pymol] with [Homebrew][hb] is with
the following method (incomplete install):

**Requirements:** The latest available XQuartz (at least 2.7.2) build of
X11.

```
# make sure that brew is up to date
brew update

# install pymol
brew tap scicalculator/pymol
brew install pymol
```

However, this method does not give access to Pymol's "External GUI"
because Pymol doesn't use the main thread for it's external gui's. To
get that working, please following the more complex installation below.
The *main GUI* works without problems, but the "external GUI" does not
yet work out of the box. There are some ways I have devised to get it to
work, but it is currently not yet as simple as I had hoped. People are
working on it :)

```
# reset if necessary (only necessary if you previsouly installed tk,tcl, or python)
brew uninstall python
brew uninstall tk
brew uninstall tcl

# get tk and tcl with threads enabled 
brew tap homebrew/dupes
brew install tk --enable-threads

# install python linked to the above tk installation
brew install python --with-brewed-tk

# don't have pmw yet? get it here:
brew tap samueljohn/python
brew install pmw

# now you can get pymol up and running like before
brew tap scicalculator/pymol
brew install pymol
```

This is almost ready for primetime. Currently this is awaiting approval at the
[Homebrew/science][hbsci] repository homebrew/homebrew-science#68.


[hb]:http://mxcl.github.com/homebrew/
[hbsci]:https://github.com/Homebrew/homebrew-science
[pymol]:http://pymol.org
