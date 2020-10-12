SET JFLEX_JAR="..\..\lib\jflex\jflex-full-1.8.2.jar"
SET JCUP_JAR="..\..\lib\cup\java-cup-11b.jar"

SET LEXICO=".\jflex\Lexico.jflex"
SET SINTACTICO=".\cup\Sintactico.cup"

SET ANALIZADORES_OUT=".\java\Analizadores"

java -jar %JFLEX_JAR% -d %ANALIZADORES_OUT% %LEXICO% 
pause

java -jar %JCUP_JAR% -destdir %ANALIZADORES_OUT% -package "Analizadores" -parser AnalizadorSintactico -symbols Simbolos %SINTACTICO%
pause

"C:\Program Files\Java\jdk1.8.0_201\bin\javaw.exe" -Dfile.encoding=Cp1252 -classpath "\TpLyC\bin;C:\Users\gise_\IdeaProjects\TpLyC\lib\cup\java-cup-11b-runtime.jar;C:\Users\gise_\IdeaProjects\TpLyC\lib\cup\java-cup-11b.jar;C:\Users\gise_\IdeaProjects\TpLyC\lib\jflex\jflex-full-1.8.2.jar" Main
pause


