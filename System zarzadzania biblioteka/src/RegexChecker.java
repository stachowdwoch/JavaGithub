
import java.util.regex.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Admin
 */
public class RegexChecker {
    public static boolean regexChecker(String theRegex, String checkStr){
        Pattern checkRegex = Pattern.compile(theRegex);
        
        Matcher regexMatcher = checkRegex.matcher(checkStr);
        
        if(regexMatcher.find())
            return true;
        return false;
    }
    
}
