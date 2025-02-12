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
        String user = properties.getProperty("db.postgres");
        String password = properties.getProperty("db.admin");

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
}