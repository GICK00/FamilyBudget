package dao;

import config.Props;
import dto.MainFormDTO;

import java.sql.*;
import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class MainFormDAO {

    public List<MainFormDTO> getAllRecords() {
        List<MainFormDTO> records = new ArrayList<>();

        Properties properties = Props.loadProperties();
        String url = properties.getProperty("db.url");
        String user = properties.getProperty("db.user");
        String password = properties.getProperty("db.password");

        try (Connection connection = DriverManager.getConnection(url, user, password)) {

            String sql = """
                SELECT 
                    fm.family_members_id, 
                    ffm.fio_family_members_surname, 
                    ffm.fio_family_members_name, 
                    ffm.fio_family_members_patronymic, 
                    fm.date_birth_family_members,
                    COALESCE(o.organization_name, 'Безработный') AS organization_name,
                    COALESCE(p.post_name, '-') AS post_name,
                    COALESCE(jfm.jobs_family_members_salary, 0) AS jobs_family_members_salary,
                    COALESCE(SUM(ep.expence_product_quantity * pr.products_price_unit), 0) AS expenses
                FROM 
                    public.family_members AS fm
                INNER JOIN 
                    public.fio_family_members AS ffm 
                    ON fm.family_members_id = ffm.fio_family_members_id
                LEFT JOIN 
                    public.jobs_family_members AS jfm 
                    ON fm.family_members_id = jfm.jobs_family_members_id
                LEFT JOIN 
                    public.organization AS o 
                    ON jfm.organization_id = o.organization_id
                LEFT JOIN 
                    public.post AS p 
                    ON jfm.post_id = p.post_id
                LEFT JOIN 
                    public.expence_product AS ep
                    ON fm.family_members_id = ep.family_members_id
                LEFT JOIN 
                    public.products AS pr
                    ON ep.products_id = pr.products_id
                GROUP BY
                    fm.family_members_id,
                    ffm.fio_family_members_surname, 
                    ffm.fio_family_members_name, 
                    ffm.fio_family_members_patronymic, 
                    fm.date_birth_family_members,
                    o.organization_name,
                    p.post_name,
                    jfm.jobs_family_members_salary
                ORDER BY
                    fm.family_members_id;""";

            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    Integer id = resultSet.getInt("family_members_id");
                    String fio = resultSet.getString("fio_family_members_surname") + " " + 
                    resultSet.getString("fio_family_members_name") + " " + 
                    resultSet.getString("fio_family_members_patronymic");
                    Date birth = resultSet.getDate("date_birth_family_members");
                    LocalDate birthDate = birth.toLocalDate();
                    LocalDate currentDate = LocalDate.now();
                    Integer age = Period.between(birthDate, currentDate).getYears();
                    String post = resultSet.getString("post_name");
                    String organization = resultSet.getString("organization_name");
                    Integer salary = resultSet.getInt("jobs_family_members_salary");
                    Integer expenses = resultSet.getInt("expenses");

                    MainFormDTO dto = new MainFormDTO(id, fio, age, post, organization, salary, expenses);
                    records.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }

    public MainFormDTO getById(int id) {
        Properties properties = Props.loadProperties();
        String url = properties.getProperty("db.url");
        String user = properties.getProperty("db.user");
        String password = properties.getProperty("db.password");
    
        String sql = """
            SELECT 
                fm.family_members_id, 
                ffm.fio_family_members_surname, 
                ffm.fio_family_members_name, 
                ffm.fio_family_members_patronymic, 
                fm.date_birth_family_members,
                COALESCE(o.organization_name, 'Безработный') AS organization_name,
                COALESCE(p.post_name, '-') AS post_name,
                COALESCE(jfm.jobs_family_members_salary, 0) AS jobs_family_members_salary,
                0 AS expenses
            FROM 
                family_members AS fm
            INNER JOIN 
                fio_family_members AS ffm 
                ON fm.family_members_id = ffm.fio_family_members_id
            LEFT JOIN 
                jobs_family_members AS jfm 
                ON fm.family_members_id = jfm.jobs_family_members_id
            LEFT JOIN 
                organization AS o 
                ON jfm.organization_id = o.organization_id
            LEFT JOIN 
                post AS p 
                ON jfm.post_id = p.post_id
            WHERE 
                fm.family_members_id = ?
        """;
    
        try (Connection connection = DriverManager.getConnection(url, user, password);
             PreparedStatement statement = connection.prepareStatement(sql)) {
    
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
    
            if (rs.next()) {
                String fio = rs.getString("fio_family_members_surname") + " " +
                             rs.getString("fio_family_members_name") + " " +
                             rs.getString("fio_family_members_patronymic");
                Date birth = rs.getDate("date_birth_family_members");
                int age = Period.between(birth.toLocalDate(), LocalDate.now()).getYears();
                String post = rs.getString("post_name");
                String org = rs.getString("organization_name");
                int salary = rs.getInt("jobs_family_members_salary");
    
                return new MainFormDTO(id, fio, age, post, org, salary, 0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    
        return null;
    }
    
    public void update(MainFormDTO dto) {
        Properties properties = Props.loadProperties();
        String url = properties.getProperty("db.url");
        String user = properties.getProperty("db.user");
        String password = properties.getProperty("db.password");
    
        String[] fioParts = dto.getFio().split(" ");
        String surname = fioParts.length > 0 ? fioParts[0] : "";
        String name = fioParts.length > 1 ? fioParts[1] : "";
        String patronymic = fioParts.length > 2 ? fioParts[2] : "";
    
        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            conn.setAutoCommit(false);
    
            PreparedStatement updateFio = conn.prepareStatement("""
                UPDATE fio_family_members
                SET fio_family_members_surname = ?, 
                    fio_family_members_name = ?, 
                    fio_family_members_patronymic = ?
                WHERE fio_family_members_id = ?
            """);
            updateFio.setString(1, surname);
            updateFio.setString(2, name);
            updateFio.setString(3, patronymic);
            updateFio.setInt(4, dto.getId());
            updateFio.executeUpdate();
    
            PreparedStatement updateJob = conn.prepareStatement("""
                UPDATE jobs_family_members
                SET jobs_family_members_salary = ?
                WHERE jobs_family_members_id = ?
            """);
            updateJob.setInt(1, dto.getSalary());
            updateJob.setInt(2, dto.getId());
            updateJob.executeUpdate();
    
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }    
}