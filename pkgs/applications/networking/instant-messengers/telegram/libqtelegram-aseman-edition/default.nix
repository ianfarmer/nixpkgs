{ stdenv, fetchFromGitHub
, qtbase, qtmultimedia, qtquick1, qmake }:

stdenv.mkDerivation rec {
  name = "libqtelegram-aseman-edition-${meta.version}";

  src = fetchFromGitHub {
    owner = "Aseman-Land";
    repo = "libqtelegram-aseman-edition";
    rev = "v${meta.version}-stable";
    sha256 = "1pfd4pvh51639zk9shv1s4f6pf0ympnhar8a302vhrkga9i4cbx6";
  };

  buildInputs = [ qtbase qtmultimedia qtquick1 ];
  enableParallelBuilding = true;
  nativeBuildInputs = [ qmake ];

  patchPhase = ''
    substituteInPlace libqtelegram-ae.pro --replace "/libqtelegram-ae" ""
    substituteInPlace libqtelegram-ae.pro --replace "/\$\$LIB_PATH" ""
  '';

  meta = with stdenv.lib; {
    version = "6.1";
    description = "A fork of libqtelegram by Aseman, using qmake";
    homepage = src.meta.homepage;
    license = licenses.gpl3;
    maintainers = [ maintainers.Profpatsch ];
    platforms = platforms.linux;
  };

}
