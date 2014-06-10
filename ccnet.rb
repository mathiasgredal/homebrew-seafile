require "formula"

class Ccnet < Formula
  homepage "http://www.seafile.com/"
  stable do
    url "https://github.com/haiwen/ccnet/archive/v3.0.5-pro.tar.gz"
    version "3.0.5-pro"
    sha1 "9aa407a3d41a3340110f41c99f39ff9146b2ceaa"
  end
  head do
    url "https://github.com/haiwen/ccnet.git"
  end

  #Silence the annoying "subdir-objects disabled" warning
  patch :p1 do
    url "https://github.com/Chilledheart/ccnet/commit/4e290a5c.diff"
    sha1 "f97591c4ef2d5baae5a4b2a10bdc31f6967face9"
  end
  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/ccnet/commit/48610f08.diff"
    sha1 "af5a53ffb9fca0d4918b9d2ef1afd54959ecf186"
  end

  depends_on 'autoconf' => :build
  depends_on "automake" => :build
  depends_on 'pkg-config' => :build
  depends_on 'libtool' => :build
  depends_on 'intltool' => :build
  depends_on 'vala' => :build
  depends_on 'glib'
  depends_on 'ossp-uuid'
  depends_on 'jansson'
  depends_on 'gettext'
  depends_on 'libzdb'
  depends_on 'libevent'
  depends_on 'libsearpc'

  if MacOS.version >= :mountain_lion
    option 'with-openssl', 'Build with OpenSSL instead of Secure Transport'
    depends_on 'openssl' => :optional
  else
    depends_on 'openssl'
  end

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--disable-server", "--enable-client"
    system "python `which searpc-codegen.py` ./lib/rpc_table.py"
    system "make"
    system "make", "install"
  end
end
