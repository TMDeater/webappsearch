package Pack;
import jdbm.RecordManager;
import jdbm.RecordManagerFactory;
import org.htmlparser.util.ParserException;

import java.io.*;
import java.util.Vector;

public class Extract_db {
	private static final int MAX = 30;
	private static int numOfPage = 0;
	private static StemStop stopStem = new StemStop("web/stopwords.txt");
	private static IndexTool PageIndexer;
	private static IndexTool WordIndexer;
	private static IndexTool FullWordIndexer;
	private static IndexTool TitleIndexer;
	private static InvertedIndex inverted;
	private static InvertedIndex ForwardIndex;
	private static InvertedIndex fullWordInverted;
	private static InvertedIndex fullWordForward;
	private static InvertedIndex ChildParent;
	private static Writer write;
	private static RecordManager recman;
	private static InvertedIndex ParentChild;
	private static PageInfm Pageppt;
	private static IndexTool maxTermFreq;
	private static InvertedIndex termWth;
	private static InvertedIndex titleForwardIndex;
	private static InvertedIndex titleInverted;
	private static IndexTool titleMaxTermFreq;
	private static InvertedIndex termWeight;
	
	
	public static void main(String[] args) throws IOException, ParserException {
		recman = RecordManagerFactory.createRecordManager("web/database");
		
		PageIndexer = new IndexTool(recman, "page");
		WordIndexer = new IndexTool(recman, "word");
		FullWordIndexer = new IndexTool(recman, "fullWord");
		TitleIndexer = new IndexTool(recman, "title");
		
		//word index
		inverted = new InvertedIndex(recman, "invertedIndex");
		ForwardIndex = new InvertedIndex(recman, "ForwardIndex");
		fullWordInverted = new InvertedIndex(recman, "fullInvertedIndex");
		fullWordForward = new InvertedIndex(recman, "fullForwardIndex");
		ChildParent = new InvertedIndex(recman, "ParentChild");
		ParentChild = new InvertedIndex(recman, "PC");
		Pageppt  = new PageInfm(recman, "PPT");
		write = new BufferedWriter(new OutputStreamWriter(
				new FileOutputStream("spider_result.txt"), "UTF8"));
		maxTermFreq = new IndexTool(recman, "maxTermFreq");
		termWth = new InvertedIndex(recman, "termWth");
		titleForwardIndex = new InvertedIndex(recman, "titleFI");
		titleInverted = new InvertedIndex(recman, "titleI");
		titleMaxTermFreq = new IndexTool(recman, "titleMaxTermFreq");

		termWeight = new InvertedIndex(recman, "termW");

		Vector<String> keywords = new Vector<String>();
		keywords.add("movie");
		//keywords.add("Planet");
		//keywords.add("(2003)");
		//keywords.add("swim");
		//keywords.add("news");
		SearchTool se = new SearchTool();
		Vector<Webpage> result = se.search(keywords);
		for (int i=0;i<result.size();i++){
			Webpage temp = result.elementAt(i);
			Vector<Word> wordVector = temp.getKeyword();
			for(int j = 0; j < wordVector.size(); j++) {
				String word = wordVector.elementAt(j).getText();
				System.out.println(word + " " + wordVector.elementAt(j).getFreq());
			}
		}
//		for(int i = 0; i < result.size(); i++){
//			generatePageInfm(result.elementAt(i).getURL());
//		}

		String stemmed=stopStem.stem("movie");
		String wordIdx=WordIndexer.getIdx(stemmed);
		System.out.println(wordIdx);
		String getting = termWeight.getValue(wordIdx);
		System.out.println(getting);
		String[] split = getting.split(" ");
		String max;
		String maxDoc = null;
		Double tempw = 0.0;
		for (int i=0;i<split.length;i++){
			String[] temp=split[i].split(":");
			if (tempw<Double.parseDouble(temp[1])) {
				tempw = Double.parseDouble(temp[1]);
				maxDoc = new String(temp[0]);
			}
		}
		System.out.println(maxDoc + ":" + String.valueOf(tempw));
		System.out.println(Pageppt.getTitle(maxDoc));
		System.out.println(maxTermFreq.getIdx(maxDoc));

		
//		int printedpage=0;
//		int i=0;
//		while( printedpage < 30){
//			String iString = String.valueOf(i);
//			String pageidxval=PageIndexer.getValue(iString);
//			int idx = PageIndexer.getIdxNumber(pageidxval);
//			if (Pageppt.getTitle(Integer.toString(idx)).equals("null")){
//				i++;
//				continue;
//			}
//			else{
//				generatePageInfm(pageidxval);
//				printedpage++;
//				i++;
//			}
//		}

			
		
		//Close output stream
		write.close();
		recman.close();
	}
	
	public static void generatePageInfm(String url) throws IOException{
		int index = PageIndexer.getIdxNumber(url);

        //title
		printAndLog(Pageppt.getTitle(Integer.toString(index)), Pageppt.getTitle(Integer.toString(index)) + "\n");
		//url
		printAndLog(Pageppt.getUrl(Integer.toString(index)), Pageppt.getUrl(Integer.toString(index))+"\n");
		//lastdate & page size
		printAndLog(Pageppt.getLastDate(Integer.toString(index))+","+Pageppt.getPageSize(Integer.toString(index)),
                Pageppt.getLastDate(Integer.toString(index))+","+Pageppt.getPageSize(Integer.toString(index))+"\n");

		
		String WordList = ForwardIndex.getValue(String.valueOf(index));
		//forward: m m m m
        //m:
        //inverted(temp2): pageindx:freq | pageindx:freq | pageindx:freq |
		String[] temp = WordList.split(" ");
		for(int i = 0; i < temp.length;i++){
			System.out.print(temp[i]+" ");
			write.append(temp[i]+" ");
			String[] temp2 = inverted.getValue(WordIndexer.getIdx(temp[i])).split(" ");
            splitColonAndPrintFreq(index, temp2);
        }


		write.append("\n");
		
		String child = ParentChild.getValue(String.valueOf(index));
		temp = child.split(" ");
		for(int i = 0; i < temp.length;i++){
			printAndLog(PageIndexer.getValue(temp[i]), PageIndexer.getValue(temp[i])+"\n");
		}

		printAndLog("-------------------------------------------------------------------------------------------",
				"-------------------------------------------------------------------------------------------\n");
	}

    public static void splitColonAndPrintFreq(int index, String[] temp2) throws IOException {
        for(int j = 0 ; j < temp2.length;j++){
            String[] temp3 = temp2[j].split(":");
            int num = Integer.parseInt(temp3[0]);
            if(index == num){
                System.out.print(" "+temp3[1]+"; ");
                write.append(" "+temp3[1]+"; ");
                break;
            }
        }
    }

    public static void printAndLog(String title, String csq) throws IOException {
		System.out.println(title);
		write.append(csq);
	}
}
