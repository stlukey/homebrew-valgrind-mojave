class ValgrindMojave < Formula
  desc "Dynamic analysis tools (memory, debug, profiling)"
  homepage "http://www.valgrind.org/"

  stable do
    url "https://github.com/o4dev/Valgrind-Mojave/releases/download/3.14/valgrind-mojave-3.14-unoffical.tar.bz2"
    sha256 "1da67a0f77f6a28a7c7117854f0601ce7c501590f3e32a09d444ded4888314ab"

    depends_on :macos => :mojave
  end

  head do
    url "https://github.com/o4dev/Valgrind-Mojave.git", :branch => "mojave"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  # Valgrind needs vcpreload_core-*-darwin.so to have execute permissions.
  # See #2150 for more information.
  skip_clean 'lib/valgrind'

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-only64bit
    ]
    system "./autogen.sh" if build.head?

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/valgrind", "ls", "-l"
  end
end
