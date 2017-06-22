import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;

public class replaceShopsJava {


    private static final String FILE_PATH = "/Users/tonyye/Git/Tibia/npc/";
    private static final String REGEX     = ".*rune,[0-9]+,([0-9]+);.*";

    public static void main(String[] args) {
        final File[] files = new File(FILE_PATH).listFiles();

        for (final File file : files) {
            try {
                final List<String> newLines = new ArrayList<String>();
                final List<String> lines    = FileUtils.readLines(file);
                for (String line : lines) {
                    if (line.matches(REGEX)) {
                        final String newValueString = StringUtil.parse(REGEX, line).group(1);
                        final int    newValue       = Integer.valueOf(newValueString) * 10;
                        line = line.replaceAll(",[0-9]{1,3};", ","+newValue+";");
                        newLines.add(line);
                    }
                    else {
                        newLines.add(line);
                    }
                }
                FileUtils.writeLines(file, newLines);
            }
            catch (final IOException e) {
                e.printStackTrace();
            }
        }
    }
}
