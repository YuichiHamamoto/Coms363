public class Attribute {
    private String name;
    private int type;
    public Attribute(String name, int type){
        this.name = name;
        this.type = type;
    }
    public void setName(String name){
        this.name= name;
    }
    public void setType(int n){
        this.type = n;
    }
    public String getName(){
        return name;
    }
    public int getType(){
        return type;
    }
}
