package forms;

import dao.MainFormDAO;
import dto.MainFormDTO;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

import java.util.function.Consumer;

public class EditForm {
    private MainFormDAO dao = new MainFormDAO();

    @SuppressWarnings("unused")
    public void showEditForm(int familyMemberId, Consumer<Void> onSavedCallback) {
        Stage stage = new Stage();
        stage.setTitle("Редактирование члена семьи ID: " + familyMemberId);

        MainFormDTO dto = dao.getById(familyMemberId);
        if (dto == null) {
            new Alert(Alert.AlertType.ERROR, "Не удалось загрузить данные").showAndWait();
            return;
        }

        GridPane grid = new GridPane();
        grid.setPadding(new Insets(10));
        grid.setVgap(10);
        grid.setHgap(10);

        TextField fioField = new TextField(dto.getFio());
        TextField ageField = new TextField(String.valueOf(dto.getAge()));
        ageField.setDisable(true);

        TextField postField = new TextField(dto.getPost());
        TextField orgField = new TextField(dto.getOrganization());
        TextField salaryField = new TextField(String.valueOf(dto.getSalary()));

        Button saveButton = new Button("Сохранить");

        grid.add(new Label("ФИО:"), 0, 0);
        grid.add(fioField, 1, 0);
        grid.add(new Label("Возраст:"), 0, 1);
        grid.add(ageField, 1, 1);
        grid.add(new Label("Должность:"), 0, 2);
        grid.add(postField, 1, 2);
        grid.add(new Label("Организация:"), 0, 3);
        grid.add(orgField, 1, 3);
        grid.add(new Label("Зарплата:"), 0, 4);
        grid.add(salaryField, 1, 4);
        grid.add(saveButton, 1, 5);

        saveButton.setOnAction(e -> {
            dto.setFio(fioField.getText());
            dto.setPost(postField.getText());
            dto.setOrganization(orgField.getText());
            try {
                dto.setSalary(Integer.parseInt(salaryField.getText()));
                dao.update(dto);
                stage.close();
                if (onSavedCallback != null) {
                    onSavedCallback.accept(null);
                }
            } catch (NumberFormatException ex) {
                new Alert(Alert.AlertType.ERROR, "Неверный формат зарплаты").showAndWait();
            }
        });

        stage.setScene(new Scene(grid, 400, 300));
        stage.show();
    }
}
