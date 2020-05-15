import java.io.File;

public class FileCount {
    public static void main(String [] args) {
        
        summarize(new File("."));
    }

    public static void summarize(final File folder) {

        long fileSize = 0;

        for (File file : folder.listFiles()) {
                if (file.isDirectory()) {       
                    summarize(file);

                }else {
                    fileSize += file.length();
                }
        }

        System.out.printf("%d\t%s\n", fileSize, folder.getPath() ); 
    }
}