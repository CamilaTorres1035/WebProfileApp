package model;

public class Skill {
    private String id;
    private String name;
    private int level;

    // Getters y setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getLevel() { return level; }
    public void setLevel(int level) { this.level = level; }

    public Skill() {}

    public Skill(String name, int level) {
        this.name = name;
        this.level = level;
    }
}