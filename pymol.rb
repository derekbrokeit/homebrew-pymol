require 'formula'

class Pymol < Formula
  homepage 'http://pymol.org'
  url 'https://pymol.svn.sourceforge.net/svnroot/pymol/trunk/pymol/', :revision => '4013'
  version '1.5'
  sha1 'b59ff50437d34f21ca8ffd007a600de4df684073'
  head 'https://pymol.svn.sourceforge.net/svnroot/pymol/trunk/pymol'

  depends_on "glew"
  depends_on "freetype"
  depends_on 'python' => 'with-brewed-tk'
  depends_on 'homebrew/dupes/tk' => 'enable-threads'
  depends_on :libpng
  depends_on :x11

  # To use external GUI tk must be built with --enable-threads
  # and python must be setup to use that version of tk with --with-brewed-tk
  depends_on 'Pmw' => :python
  depends_on 'Tkinter' => :python

  option 'default-mono', 'Set mono graphics as default'

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
    p = [ DATA ]
    p << 'https://gist.github.com/raw/1b84b2ad3503395f1041/2a85dc56b4bd1ea28d99ce0b94acbf7ac880deff/pymol_disable_stereo.diff' if build.include? 'default-mono'
    p
  end

  def which_python
    "python" + `python -c 'import sys;print(sys.version[:3])'`.strip
  end

  def test
    # commandline test
    system "pymol", "-c"
    # hardcore bench test
    system "pymol","-M","-b","-d","quit"
  end

  def caveats
    <<-EOS.undent

    On some macs, the graphics drivers do not properly support stereo
    graphics. This will cause visual glitches and shaking that stay
    visible until x11 is completely closed. If this affects your
    computer, you may want to install with the '--default-mono' option
    or run pymol with the "-M" flag.

      pymol -M

    If you use '--default-mono', you can still try stereo by running:

      pymol -S

    EOS
  end
      
end

__END__
diff --git a/setup.py b/setup.py
index b5819d6..0f40b2e 100644
--- a/setup.py
+++ b/setup.py
@@ -153,7 +153,7 @@ elif sys.platform=='darwin':
         outputheader.close()
         outputfile.close()
 
-        EXT = "/opt/local"
+        EXT = "HOMEBREW_PREFIX"
         inc_dirs=["ov/src",
                   "layer0","layer1","layer2",
                   "layer3","layer4","layer5",
