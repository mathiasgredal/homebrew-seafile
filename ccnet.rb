require "formula"

class Ccnet < Formula
  homepage "http://www.seafile.com/"
  #stable do
  #  url "https://github.com/haiwen/ccnet/archive/v3.0.5-pro.tar.gz"
  #  version "3.0.5-pro"
  #  sha1 "9aa407a3d41a3340110f41c99f39ff9146b2ceaa"
  #end
  head do
    url "https://github.com/haiwen/ccnet.git"
  end

  #[FIX] homebrew autotools path
  patch :p1 do
    url "https://github.com/Chilledheart/ccnet/commit/48610f08.diff"
    sha1 "af5a53ffb9fca0d4918b9d2ef1afd54959ecf186"
  end

  option 'without-client', 'Disable building client'
  option 'with-server', 'Build with server part'
  option 'without-brewed-openssl', "Build without Homebrew OpenSSL"
  option 'with-brewed-sqlite', 'Build with Homebrew sqlite3'

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
  depends_on 'sqlite' if build.with? 'brewed-sqlite'

  #Compatiblity issue with Apple's Secure Transport
  depends_on 'openssl' if build.with? 'brewed-openssl'

  def install

    args = %W[
      --prefix=#{prefix}
    ]

    if build.with? 'server'
      args << '--enable-server'
    else
      args << '--disable-server'
    end

    if build.with? 'client'
      args << '--enable-client'
    else
      args << '--disable-client'
    end

    system "./autogen.sh"
    system "./configure", *args
    system "python `which searpc-codegen.py` ./lib/rpc_table.py"
    system "make"
    system "make", "install"
  end
end
