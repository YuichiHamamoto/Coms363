import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.channels.WritableByteChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;


public class Toy {
    private static final Set<Character> ILLEGAL_CHARACTERS = new HashSet<>(Arrays.asList('/', '\n', '\r', '\t', '\0', '\f', '`', '?', '*', '\\', '<', '>', '|', '\"', ':','$','{','}','[',']'));
    private static HashMap <String, Integer> map;
    
    private static ArrayList<Attribute> attr; //header
    private static ArrayList<ArrayList<String>> record; 

    public static void main(String[]args){
        Scanner sc = new Scanner(System.in);
        System.out.printf("Toy: ");
        while(sc.hasNextLine()){
            String [] prompt = sc.nextLine().replaceAll("( )+", " ").split(" ");
            if(prompt == null||prompt[0]==null){
                return;
            }
            else{
                switch(prompt[0]){
                    //Toy create xyz.tb
                    case "create":
                        if(prompt.length==2){
                            create(prompt[1]);
                        }
                        else{
                            System.out.println("Invalid command");
                        }
                        break;
                    //Toy header xyz.tb
                    case "header":
                        if(prompt.length==2){
                            header(prompt[1]);
                        }
                        else{
                            System.out.println("Invalid command");
                        }
                        break;
                    //Toy insert xyz.tb
                    case "insert":
                        if(prompt.length==2){
                            insert(prompt[1]);
                        }
                        else{
                            System.out.println("Invalid command");
                        }
                        break;
                    //Toy display rid xyz.tb
                    case "display":
                        if(prompt.length==3){
                            display(Integer.parseInt(prompt[1]),prompt[2]);
                        }
                        else{
                            System.out.println("Invalid command");
                        }
                        break;
                    //Toy delete rid xyz.tb
                    case "delete":
                        if(prompt.length==3){
                            delete(Integer.parseInt(prompt[1]),prompt[2]);
                        }
                        else{
                            System.out.println("Invalid command");
                        }
                    //Toy search "condition" xyz.tb
                    case "search":
                        if(prompt.length>=3){
                            StringBuilder st = new StringBuilder();
                            st.append(prompt[1]);
                            for(int i = 2;i<prompt.length-1;i++){
                                st.append(prompt[i]);
                            }
                            search(st.toString(),prompt[prompt.length-1]);
                        }
                        else{
                            System.out.println("Invalid command");
                        }
                        break;
                    //EXIT
                    case "exit": 
                        return;
                }
            }
            System.out.printf("Toy: ");
        }
    }

    public static void create(String st){
        map = new HashMap<>();
        attr = new ArrayList<>();
        boolean next = true;
        Scanner sc = new Scanner(System.in);

        //take input
        while(next){
            System.out.println("Attribute name: ");
            String name = sc.nextLine();

            //validate the name
            if(isInvalid(name)){
                continue;
            }

            System.out.println("Select a type: 1. integer; 2. double; 3. boolean; 4. string");
            int type = Integer.parseInt(sc.nextLine());
            map.put(name, type);
            attr.add(new Attribute(name, type));

            System.out.println("More attribute? (y/n)");
            String ans = sc.nextLine();
            if(ans == null||ans.length()==0||ans.equals("")||!ans.equals("y")){
                next = false;
            }
        }

        //create a file
        try {
            File file = new File(st);
            if (file.createNewFile()) {
              System.out.println("File created: " + file.getName());
            } else {
              System.out.println("File already exists.");
            }
          } catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }

        String header = createHeader();
        
        try {
            FileWriter myWriter = new FileWriter(st);
            myWriter.write(header.toString());
            myWriter.close();
            System.out.println("Successfully wrote to the file.");
        } 
        catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
    }

    public static void header(String name){
        try {
            File file = new File(name);
            Scanner sc = new Scanner(file);
            if(sc.hasNextLine()) {
                String [] st = sc.nextLine().split("\\[");
                for(int i = 1; i<st.length;i++){
                    st[i] = st[i].substring(0,st[i].length()-1);
                }
                StringBuilder header = new StringBuilder();
                header.append(st[1]);
                header.append(" attributes.\n");
                for(int i = 2;i<st.length-1;i++){
                    String [] att = st[i].split(":");
                    String t = findType(Integer.parseInt(att[1]));
                    header.append("Attribute ");
                    header.append(i-1);
                    header.append(": ");
                    header.append(att[0]);
                    header.append(", ");
                    header.append(t);
                    header.append("\n");
                }
                header.append(st[st.length-1]+" record(s)");
                String h = new String(header);
                if(h==null){
                    System.out.printf("Toy: ");
                }
                else{
                    System.out.println(h);
                }
            }
            sc.close();
          } 
          catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
          }
    }
    
    public static void insert(String name){
        File f = new File(name);
        if(readHeader(name)&&readAtt(name)) { 
            Scanner sc = new Scanner(System.in);

            ArrayList<String> l = new ArrayList<>();
            //insert record into record
            for(int i = 0;i<attr.size();i++){
                System.out.printf(attr.get(i).getName()+": ");
                String val = sc.nextLine();
                switch(attr.get(i).getType()){
                    case 1:
                    if(!isNumeric(val)){
                        System.out.println("Error: input is not int");
                        return;
                    }
                    case 2:
                    if(!isNumeric(val)){
                        System.out.println("Error: input is not Double");
                        return;
                    }
                    else{
                        l.add(val);
                        continue;
                    }
                    case 3:
                    if(!val.equals("T")&&!val.equals("F")){
                        System.out.println("Error: input is not boolean. Answer with T or F");
                        return;
                    }
                    else{
                        l.add(val);
                        continue;
                    }
                    case 4:
                    if(validateString(val)){
                        return;
                    }
                }
                l.add(val);
            }
            
            record.add(l);

            StringBuilder txt = new StringBuilder(createHeader());
            txt.append("\n");
            txt.append(createAtt());
            try {
                FileWriter myWriter = new FileWriter(name);
                myWriter.write(txt.toString());
                myWriter.close();
                System.out.println("Successfully wrote to the file.");
            } 
            catch (IOException e) {
                System.out.println("An error occurred.");
                e.printStackTrace();
            }
        }
    }

    public static void display(int rid,String name){
        readHeader(name);
        readAtt(name);
        if(record.size()-1<rid){
            System.out.println("Error rid out of index");
            return;
        }
        for(int i = 0;i< attr.size();i++){
            System.out.printf("%s: %s\n", attr.get(i).getName(), record.get(rid).get(i));
        }
    }

    public static void delete(int rid, String name){
        readHeader(name);
        readAtt(name);
        if(record.size()-1<rid){
            System.out.println("Error rid out of index");
            return;
        }
        record.remove(rid);
        StringBuilder txt = new StringBuilder(createHeader());
        txt.append("\n");
        txt.append(createAtt());
        try {
            FileWriter myWriter = new FileWriter(name);
            myWriter.write(txt.toString());
            myWriter.close();
            System.out.println("Successfully wrote to the file.");
        } 
        catch (IOException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
        
        System.out.println("Successfully deleted rid "+ rid);
    }

    public static void search(String condition, String name){
        readHeader(name);
        readAtt(name);
        condition = condition.replaceAll("\\s+","");
        String []st = condition.split("=");
        if(st.length!=2){
            System.out.println("invalid condistion");
            return;
        }
        int index = 0;
        for(int i= 0; i<attr.size();i++){
            if(attr.get(i).getName().equals(st[0])){
                index = i;
            }
        }
        for(int i = 0;i<record.size();i++){
            if(record.get(i).get(index).equals(st[1])){
                System.out.printf("Record %d\n",i);
                for(int j = 0;j< record.get(i).size();j++){
                    System.out.printf("%s: %s\n",attr.get(j).getName(),record.get(i).get(j));
                }
                System.out.println();
            }
        }
    }

    public static boolean isInvalid(String s){
        if(s.length()==0||s==null||s.equals("")){
            System.out.println("The input is empty. Try again");
            return true;
        }else if(isNumeric(Character.toString(s.charAt(0)))){
            System.out.println("You cannot start from number. Try again");
            return true;
        }else if(map.containsKey(s)){
            System.out.println("The name was already there. Choose a different name");
            return true;
        }else{
            for(int i = 0; i<s.length();i++){
                if(ILLEGAL_CHARACTERS.contains(s.charAt(i))){
                    System.out.println("An invalid char was included. Try again");
                    return true;
                }
            }
        }
        return false;
    }

    public static boolean validateString(String s){
        if(s.length()==0||s==null||s.equals("")){
            System.out.println("The input is empty. Try again");
            return true;
        }else{
            for(int i = 0; i<s.length();i++){
                if(ILLEGAL_CHARACTERS.contains(s.charAt(i))){
                    System.out.println("An invalid char was included. Try again");
                    return true;
                }
            }
        }
        return false;
    }

    public static boolean isNumeric(String s) {  
    return s != null && s.matches("[-+]?\\d*\\.?\\d+");  
}  

    public static String findType(int n){
        switch (n){
            case 1:
            return "int";

            case 2:
            return "double";

            case 3:
            return "boolean";

            case 4:
            return "String";
        }
        return null;
    }

    public static boolean readHeader(String name){
        attr = new ArrayList<>();
        map = new HashMap<>();
        try {
            File file = new File(name);
            Scanner sc = new Scanner(file);
            if(sc.hasNextLine()) {
                String [] st = sc.nextLine().split("\\[");
                for(int i = 1; i<st.length;i++){
                    st[i] = st[i].substring(0,st[i].length()-1);
                }
                int len = Integer.parseInt(st[1]);
                for(int i = 2;i<len+2;i++){
                    String [] att = st[i].split(":");
                    attr.add(new Attribute(att[0],Integer.parseInt(att[1]))); 
                    map.put(att[0],Integer.parseInt(att[1]));
                }
            }
            sc.close();
            return true;
        } 
        catch (FileNotFoundException e) {
            System.out.println("The file doesn't exist");
            e.printStackTrace();
            return false;
        }  
    }

    public static boolean readAtt(String name){
        record = new ArrayList<>();
        try {
            File file = new File(name);
            Scanner sc = new Scanner(file);
            if(sc.hasNextLine()) {
                sc.nextLine();
                while(sc.hasNextLine()){
                    String l = sc.nextLine();
                    l = l.substring(1,l.length()-1);
                    String st[] = l.split("\\|");
                    ArrayList<String> list = new ArrayList<>();
                    for(int i = 0;i<st.length;i++){
                        list.add(st[i]);
                    }
                    record.add(list);
                }
            }
            sc.close();
            return true;
        } 
        catch (FileNotFoundException e) {
            System.out.println("The file doesn't exist");
            e.printStackTrace();
            return false;
        }
    }

    public static String createHeader(){
        //create header
        StringBuilder header = new StringBuilder();
        header.append("[");
        header.append(attr.size());
        header.append("]");

        for(int i = 0;i < attr.size();i++){
            header.append("[");
            header.append(attr.get(i).getName());
            header.append(":");
            header.append(attr.get(i).getType());
            header.append("]");
        }
        header.append("[");
        if(record==null||record.size()==0){
            header.append(0);
        }
        else{
            header.append(record.size());
        }
        header.append("]");
        return new String(header);
    }

    public static String createAtt(){
        StringBuilder att = new StringBuilder();
        for(int i = 0; i<record.size();i++){
            att.append("{");

            for(int j = 0; j<record.get(i).size();j++){
                if(j ==0){
                    att.append(record.get(i).get(j));
                }
                else{
                    att.append("|");
                    att.append(record.get(i).get(j));
                }
            }
            att.append("}\n");
        }
        return new String(att);
    }
}
