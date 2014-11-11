require "formula"

class Libsearpc < Formula
  homepage "http://www.seafile.com/"
  url "https://github.com/haiwen/libsearpc/archive/v3.0-latest.tar.gz"
  version "4.0.0"
  sha1 "cdff106886441205f46a592100ae324314127107"

  head "https://github.com/haiwen/libsearpc.git"

  #FIX for homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/libsearpc/commit/7df8246d.diff"
    sha1 "981027078d9b1eb6b7c5b5a917fbb2d6fa39e029"
  end

  depends_on 'autoconf' => :build
  depends_on "automake" => :build
  depends_on 'pkg-config' => :build
  depends_on 'libtool' => :build
  depends_on 'jansson'
  depends_on 'gettext'
  depends_on 'glib'

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
