package dto;

public class MainFormDTO {
    private int id;
    private String fio;
    private int age;
    private String post;
    private String organization;
    private int salary;
    private int expenses;

    public MainFormDTO(int id, String fio, int age, String post, String organization, int salary, int expenses) {
        this.id = id;
        this.fio = fio;
        this.age = age;
        this.post = post;
        this.organization = organization;
        this.salary = salary;
        this.expenses = expenses;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFio() {
        return fio;
    }

    public void setFio(String fio) {
        this.fio = fio;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public int getExpenses() {
        return expenses;
    }

    public void setExpenses(int expenses) {
        this.expenses = expenses;
    }
}