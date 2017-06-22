import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FileUtils;

public class replaceItemParametersJava {

    static final String FILE_NAME = "/Users/tonyye/Git/Tibia/items/items.xml";
    static       String regex     = ".*key=\"attack\" value=\"([1-2][0-9])\".*";

    public static void main(String[] args) {
        try {
            List<String> newLines = new ArrayList<String>();
            List<String> lines    = FileUtils.readLines(FileUtils.getFile(FILE_NAME));
            for (String line : lines) {
                if (line.matches(regex)) {
                    final String newAttackString = StringUtil.parse(regex, line).group(1);
                    final int    newAttack       = Integer.valueOf(newAttackString) * 2;
                    line = line.replaceAll("[0-9]+", String.valueOf(newAttack));
                    newLines.add(line);
                }
                else {
                    newLines.add(line);
                }
            }
            FileUtils.writeLines(FileUtils.getFile(FILE_NAME), newLines);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }
}
