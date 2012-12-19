require 'formula'

class Pymol < Formula
  homepage 'http://pymol.org'
  url 'https://pymol.svn.sourceforge.net/svnroot/pymol/trunk/pymol/', :revision => '4013'
  version '1.5'
  sha1 'b59ff50437d34f21ca8ffd007a600de4df684073'

  head 'https://pymol.svn.sourceforge.net/svnroot/pymol/trunk/pymol'

  depends_on "glew"
  depends_on "freetype"
  depends_on :libpng
  depends_on :x11

  # depends on the Pmw and Tkinter python packages
  # this, however, does not check full compatability
  # To use external GUI tk must be built with --enable-threads
  # and python must be setup to use that version of tk with --with-brewed-tk
  depends_on 'Pmw' => :python
  depends_on 'Tkinter' => :python

  def install
    temp_site_packages = lib/which_python/'site-packages'
    mkdir_p temp_site_packages
    ENV['PYTHONPATH'] = temp_site_packages

    args = [
      "build",
      "install",
      "--home=#{temp_site_packages}",
      "--install-lib=#{temp_site_packages}",
    ]

    # build the pymol libraries
    system "python", "-s", "setup.py", *args
    system "python", "-s", "setup2.py", "install"

    # get the executable
    bin.install("pymol")
  end

  def patches
    # This fixes the setup.py script so that it no longer assumes MacPorts
    # http://sourceforge.net/mailarchive/forum.php?thread_name=CAEoiczdti8kXoVsLpwtRNW3%3DE44PQ1jT%3Dv-cpB2DCotGq8sEjQ%40mail.gmail.com&forum_name=pymol-users
    # This patch can be removed as soon as the pymol setup script is less strict about where it gets it's  headers and libraries
    { :p0 => "https://gist.github.com/raw/4267806/9f94f1478251f2f7b01fbed1fd01614ab7681d06/gistfile1.diff" }
  end

  def which_python
    "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
  end

  def test
    system "pymol", "-c"
  end

  def caveats
    <<-EOS.undent
      You can set PYMOL_PATH in your environment to save
      plugins and scripts. To a central location. Homebrew
      does not maintain this.
        ex. 
          export PYMOL_PATH="$HOME/pymol

      --- 
      Onoe, is your external GUI missing?

      In ordert to successfully use pymol's external GUI,
      you must install tcl and tk with '--enable-threads'. 
      and then link python to it. Don't forget  to uninstall
      tk, tcl, and python brews if you already had them.

        brew tap homebrew/dupes
        brew install tk --enable-threads
        brew install python --with-brewed-tk

      Additionally, if you don't already have it, you should
      get the Python megawidgets package.

        brew tap samueljohn/python
        brew install pmw
      ---

      License information is here:
      #{prefix}/LICENSE
    EOS
  end
      
end
