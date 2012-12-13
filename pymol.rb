require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Pymol < Formula
    homepage 'http://pymol.org'
    # the current 'stable' version does not build, please use the '--HEAD' flag for now
    #url 'http://downloads.sourceforge.net/project/pymol/pymol/1.5.0.1/pymol-v1.5.0.1.tar.bz2'
    version '1.5.0.1'
    sha1 'b59ff50437d34f21ca8ffd007a600de4df684073'

    head 'https://pymol.svn.sourceforge.net/svnroot/pymol/trunk/pymol'

    depends_on "glew"
    depends_on "tk"
    depends_on "freetype"
    depends_on :libpng
    depends_on :x11

    # depends on the Pmw module in python
    depends_on 'Pmw' => :python

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
        # this was be submitted upstream
        # http://sourceforge.net/mailarchive/forum.php?thread_name=CAEoiczdti8kXoVsLpwtRNW3%3DE44PQ1jT%3Dv-cpB2DCotGq8sEjQ%40mail.gmail.com&forum_name=pymol-users
        # This patch can be removed as soon as the pymol seteup script is less strict about where it gets it's  headers and libraries
        { :p0 => "https://gist.github.com/raw/4267806/9f94f1478251f2f7b01fbed1fd01614ab7681d06/gistfile1.diff" }
    end

    def which_python
        "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
    end

    def test
        system "pymol", "-c"
    end
end
