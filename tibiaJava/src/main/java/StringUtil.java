import java.text.Normalizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by patrikburstrom on 01/03/16.
 */
public class StringUtil {
    /**
     * Normalize String to SWIFT compliant characters. All language specific letters are normalized to a-zA-Z0-9 and remove all special characters, except: / - ? : ( ) . , + and space
     * @param s the String to clean
     * @return the clean String
     */
    public static String normalizeToSwiftCompliantCharacters(String s) {
        return Normalizer.normalize(s, Normalizer.Form.NFD).replaceAll("[^A-Za-z0-9 \\/\\-\\?:\\(\\)\\.,\\+]", "");
    }

    /**
     * Replaces all newline and space characters with a regular space, removes leading and trailing white space
     * @param s the String to clean
     * @return the clean String
     */
    public static String normalizeSpaces(String s) {
        return s.replaceAll("[\\s\\p{Z}]+", " ").trim();
    }

    /**
     * Replaces all space characters with a regular space, removes leading and trailing white space
     * @param s the String to clean
     * @return the clean String
     */
    public static String normalizeSpacesKeepLineBreak(String s) {
        return s.replaceAll("[ \\t\\r\\p{Z}]+", " ").trim();
    }


    /**
     * Parse a string according to a given regex.
     *
     * @param regex the given regex
     * @param toParse String to be parsed
     * @return the resulting Matcher object, already matched (using .matches())
     * @throws java.lang.RuntimeException if regex doesn't match toParse
     */
    public static Matcher parse(String regex, String toParse) {
        return parse(Pattern.compile(regex), toParse);
    }

    /**
     * Parse a string according to a given pattern.
     *
     * @param pattern the given pattern
     * @param toParse String to be parsed
     * @return the resulting Matcher object, already matched (using .matches())
     * @throws java.lang.RuntimeException if pattern doesn't match toParse
     */
    public static Matcher parse(Pattern pattern, String toParse) {
        final Matcher matcher = pattern.matcher(toParse);
        if (!matcher.matches()) {
            throw new RuntimeException("The pattern \"" + pattern + "\" does not match the string \"" + toParse + "\"!");
        }
        return matcher;
    }

    /**
     * Segments, or 'airs' a string, by adding a space every four characters.
     *
     * @param string the string to be segmented
     * @return the segmented string
     */
    public static String segment(String string, int chunkSize) {
        final StringBuilder builder = new StringBuilder();
        final int length = string.length();
        for (int i = 0; i < length; i += chunkSize) {
            builder.append(string.substring(i, Math.min(i + chunkSize, length)));
            builder.append(" ");
        }
        return builder.toString().trim();
    }
}
