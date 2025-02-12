package dao;

import config.Props;
import dto.MainFormDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

public class MainFormDAO {

    public List<MainFormDTO> getAllRecords() {
        List<MainFormDTO> records = new ArrayList<>();

        Properties properties = Props.loadProperties();
        String url = properties.getProperty("db.FamilyBudget");
        String user = properties.getProperty("db.postgres");
        String password = properties.getProperty("db.admin");

        try (Connection connection = DriverManager.getConnection(url, user, password)) {

            String sql = """  """;

            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    Integer id = resultSet.getInt("id");
                    String type = resultSet.getString("partner_type");
                    String name = resultSet.getString("name");
                    String director = resultSet.getString("director");
                    String phone = resultSet.getString("partner_phone");
                    Integer rating = resultSet.getInt("rating");
                    Integer discount = resultSet.getInt("discount");

                    MainFormDTO dto = new MainFormDTO();
                    records.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return records;
    }
}