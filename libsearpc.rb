require "formula"

class Libsearpc < Formula
  homepage "http://www.seafile.com/"
  stable do
    url "https://github.com/haiwen/libsearpc/archive/v3.0.5-pro.tar.gz"
    version "v3.0.5-pro"
    sha1 "cc79c6fba507cb616e86266ec34d1a89d4f12283"
  end
  head do
    url "https://github.com/haiwen/libsearpc.git"
  end

  #Detect darwin platform for autotools
  patch :p1 do
    url "https://github.com/Chilledheart/libsearpc/commit/2e2adb.diff"
    sha1 "3512f7a105d9f89be9389aba71996d08601e3cfb"
  end
  #FIX for homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/libsearpc/commit/70d44f.diff"
    sha1 "ac4c411d9793ba88f1cd66975c19635d3fab36ef"
  end
  #Fix a bug with coreutils installed under Mac OS X
  patch :p1 do
    url "https://github.com/Chilledheart/libsearpc/commit/665832.diff"
    sha1 "b33f4e571c3ad77593d18130a077fbf40f14358d"
  end

  depends_on 'autoconf' => :build
  depends_on "automake" => :build
  depends_on 'pkg-config' => :build
  depends_on 'libtool' => :build
  depends_on 'jansson'
  depends_on 'glib'

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
