package forms;

import dao.MainFormDAO;
import javafx.application.Application;
import javafx.concurrent.Worker;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.VBox;
import javafx.scene.web.WebEngine;
import javafx.scene.web.WebView;
import javafx.stage.Stage;
import netscape.javascript.JSObject;

public class MainForm extends Application {

    private WebView webView;
    private MainFormDAO dao = new MainFormDAO();

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("Программный модуль учета семейного бюджета");

        Image logo = new Image(getClass().getResourceAsStream("/assets/img/Лого.png"));
        Image icon = new Image(getClass().getResourceAsStream("/assets/Лого.ico"));

        webView = new WebView();
        updateWebView();

        VBox root = new VBox();
        ImageView logoView = new ImageView(logo);
        logoView.setFitWidth(100);
        logoView.setPreserveRatio(true);

        root.getChildren().addAll(logoView, webView);

        Scene scene = new Scene(root);

        primaryStage.getIcons().add(icon);
        primaryStage.setScene(scene);
        primaryStage.show();

        webView.prefWidthProperty().bind(root.widthProperty());
    }

    @SuppressWarnings({ "unused" })
    private void updateWebView() {
        var partners = dao.getAllRecords();

        StringBuilder htmlContent = new StringBuilder("""
                <!DOCTYPE html>
                <html lang="ru">
                <head>
                    <meta charset="cp1251">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <style>
                        .list-container {
                            width: 100%;
                            margin: 0 auto;
                            padding: 20px;
                            border: 2px solid #ccc;
                            border-radius: 8px;
                            background-color: #FFFFFF;
                        }

                        /* Стили для элемента списка */
                        .list-item {
                            border: 2px solid #ccc;
                            border-radius: 8px;
                            margin-bottom: 20px;
                            padding: 15px;
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                            background-color: #EBE84B;
                        }

                        .list-item table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        .list-item:hover {
                                    background-color: #B11AED;
                        }

                        .list-item table td {
                            padding: 1px;
                        }

                        .list-item table td:first-child {
                            width: 80%;
                        }

                        .list-item table td:last-child {
                            width: 20%;
                        }
                    </style>
                </head>
                <body style = "width:90%">
                    <div class="list-container">
                """);

        for (var partner : partners) {
            htmlContent.append("<div class=\"list-item\" onClick = \"window.listListener.clickItem(")
                    .append(partner.getId())
                    .append(")\"")
                    .append("><table><tr><td>")
                    .append(partner.getFio())
                    .append("</td><td>")
                    .append("<tr><td>Возраст ")
                    .append(partner.getAge())
                    .append("</td><td>Расход: ")
                    .append(partner.getExpenses())
                    .append("</td></tr>");
            htmlContent.append("<tr><td>")
                    .append(partner.getPost())
                    .append("</td><td></td></tr>");
            htmlContent
                    .append("<tr><td>")
                    .append(partner.getOrganization())
                    .append("</td><td></td></tr>");
            htmlContent
                    .append("<tr><td>Доход: ")
                    .append(partner.getSalary())
                    .append("</td><td></td></tr></table></div>");
        }
        htmlContent.append("""
                    </div>
                </body>
                </html>
                """);

        WebEngine webEngine = webView.getEngine();

        webEngine.getLoadWorker().stateProperty().addListener(
            (observable, oldValue, newValue) -> {
                if (newValue == Worker.State.SUCCEEDED) {
                    JSObject window = (JSObject) webEngine.executeScript("window");
                    window.setMember("listListener", new ListListener(this));
                }
            });

        webEngine.loadContent(htmlContent.toString());
    }

    public static class ListListener {
        private MainForm mainForm;

        public ListListener(MainForm mainForm) {
            this.mainForm = mainForm;
        }

        @SuppressWarnings("unused")
        public void clickItem(int id) {
            EditForm editForm = new EditForm();
            editForm.showEditForm(id, (v) -> mainForm.updateWebView());
        }
    }
}