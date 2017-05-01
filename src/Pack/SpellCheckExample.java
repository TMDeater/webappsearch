/*
Jazzy - a Java library for Spell Checking
Copyright (C) 2001 Mindaugas Idzelis
Full text of license can be found in LICENSE.txt

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
*/
package Pack;

import com.swabunga.spell.engine.SpellDictionary;
import com.swabunga.spell.engine.SpellDictionaryHashMap;
import com.swabunga.spell.event.*;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

/** This class shows an example of how to use the spell checking capability.
 *
 * @author Jason Height (jheight@chariot.net.au)
 */
public class SpellCheckExample implements SpellCheckListener {

  private static String dictFile = "D:\\webappsearch\\web\\dict\\wordlist.txt";

  private static SpellChecker spellCheck = null;
  private Vector<String> misspelledWords;


  public SpellCheckExample() {
    try {
      SpellDictionary dictionary = new SpellDictionaryHashMap(new File(dictFile));

      spellCheck = new SpellChecker(dictionary);
      spellCheck.addSpellCheckListener(this);
      BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

      while (true) {
        System.out.print("Enter text to spell check: ");
        String line = in.readLine();

        if (line.length() <= 0)
          break;
        spellCheck.checkSpelling(new StringWordTokenizer(line));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }


  public static Vector<String> check(Vector<String> query) throws IOException {
    SpellDictionary dictionary = new SpellDictionaryHashMap(new File(dictFile));
    spellCheck = new SpellChecker(dictionary);
    List<com.swabunga.spell.engine.Word> suggestion = new Vector<>();
    Vector<String> result = new Vector<>();
    for (String word:query) {
      suggestion = spellCheck.getSuggestions(word, 0);
      int count = 0;
      for (com.swabunga.spell.engine.Word suggestWord:suggestion){
        result.add(suggestWord.getWord());
        count++;
        if (count>=5){
          break;
        }
      }
    }
    return result;
  }

  public void spellingError(SpellCheckEvent event) {
    List suggestions = event.getSuggestions();
    if (suggestions.size() > 0) {
      System.out.println("MISSPELT WORD: " + event.getInvalidWord());
      for (Iterator suggestedWord = suggestions.iterator(); suggestedWord.hasNext();) {
        System.out.println("\tSuggested Word: " + suggestedWord.next());
      }
    } else {
      System.out.println("MISSPELT WORD: " + event.getInvalidWord());
      System.out.println("\tNo suggestions");
    }
    //Null actions
  }

  public static void main(String[] args) throws IOException {
    Vector<String> q = new Vector<>();
    q.add("dinosour");
    q.add("dog");
    q.add("evat");
    for (String word:SpellCheckExample.check(q)){
      System.out.println(word);
    }
  }
}
