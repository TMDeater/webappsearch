package Pack;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashSet;
import java.io.*;

public class StemStop{
  private HashSet stopwd;
  private Porter porter;

  public boolean isStopWord(String string){
      boolean a= stopwd.contains(string);
    return stopwd.contains(string);
  }

//constructor
  public StemStop(String string){
    super();
    try{
      porter = new Porter();
      stopwd = new HashSet();
//readd stopword.txt file and put in HashSet
      FileInputStream filestream = new FileInputStream(string);
      DataInputStream input = new DataInputStream(filestream);
      BufferedReader buffer = new BufferedReader(new InputStreamReader(input, "utf-8"));
      String strLine;
      while ((strLine = buffer.readLine()) != null){
        stopwd.add(strLine);
      }
      input.close();
    }
    catch(Exception exception){
      System.err.println("Error Found: "+exception.getMessage());
    }
  }

  public StemStop(URL url){
      super();

      try {
          porter = new Porter();
          stopwd = new HashSet();
          BufferedReader in = new BufferedReader(
                  new InputStreamReader(url.openStream()));
          String inputLine;
          while ((inputLine = in.readLine()) != null)
              stopwd.add(inputLine);
          in.close();

      } catch (IOException e) {
          e.printStackTrace();
      }
  }

  public String stem(String string){
    return porter.stripAffixes(string);
  }

//run in main
  public static void main(String[] arg) throws MalformedURLException {
    StemStop stopStem = new StemStop(new URL("http://localhost:8080/stopwords.txt"));
		String input="";
		try{
			do
			{
				System.out.print("Please enter a single English word: ");
				BufferedReader in = new BufferedReader(new InputStreamReader(System.in, "utf-8"));
				input = in.readLine();
				if(input.length()>0)
				{
					if (stopStem.isStopWord(input))
						System.out.println("It should be stopped");
					else
			   			System.out.println("The stem of it is \"" + stopStem.stem(input)+"\"");
				}
			}
			while(input.length()>0);
		}
		catch(IOException ioe)
		{
			System.err.println(ioe.toString());
    }
  }
}
