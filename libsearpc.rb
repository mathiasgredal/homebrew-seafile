require "formula"

class Libsearpc < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/libsearpc/archive/v3.0-latest.tar.gz"
  version "4.0.0"
  revision 1
  sha1 "cdff106886441205f46a592100ae324314127107"

  head "https://github.com/haiwen/libsearpc.git"

  #FIX for homebrew autotools path
  patch :DATA

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "jansson"
  depends_on "glib"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end

__END__
diff --git a/autogen.sh b/autogen.sh
index b6a7d24..af0d8d7 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -60,7 +60,7 @@ fi
 if test x"$MSYSTEM" = x"MINGW32"; then
     autoreconf --install -I/local/share/aclocal
 elif test "$(uname -s)" = "Darwin"; then
-    autoreconf --install -I/opt/local/share/aclocal
+    autoreconf --install -I/usr/local/share/aclocal
 else
     autoreconf --install
 fi
