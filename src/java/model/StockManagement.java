
package model;

import dal.StockDAO2;
import model.Stock;
import java.util.List;
import java.util.Scanner;

public class StockManagement {
    public static void main(String[] args) {
        StockDAO2 stockDAO = new StockDAO2();
        Scanner scanner = new Scanner(System.in);
        int choice;

        do {
            System.out.println("\nStock Management System");
            System.out.println("1. Add Stock");
            System.out.println("2. View All Stocks");
            System.out.println("3. Update Stock Quantity");
            System.out.println("4. Delete Stock");
            System.out.println("0. Exit");
            System.out.print("Enter choice: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    System.out.print("Enter ProductID: ");
                    int productID = scanner.nextInt();
                    System.out.print("Enter WarehouseID: ");
                    int warehouseID = scanner.nextInt();
                    System.out.print("Enter ZoneID: ");
                    int zoneID = scanner.nextInt();
                    System.out.print("Enter BinID: ");
                    int binID = scanner.nextInt();
                    System.out.print("Enter Quantity: ");
                    int quantity = scanner.nextInt();
                    stockDAO.addStock(new Stock(0, productID, warehouseID, zoneID, binID, quantity, null));
                    break;
                case 2:
                    List<Stock> stocks = stockDAO.getAllStocks();
                    stocks.forEach(stock -> System.out.println(stock.getStockID() + " - " + stock.getQuantity()));
                    break;
                case 3:
                    System.out.print("Enter StockID to update: ");
                    int stockID = scanner.nextInt();
                    System.out.print("Enter new Quantity: ");
                    int newQuantity = scanner.nextInt();
                    stockDAO.updateStockQuantity(stockID, newQuantity);
                    break;
                case 4:
                    System.out.print("Enter StockID to delete: ");
                    int delStockID = scanner.nextInt();
                    stockDAO.deleteStock(delStockID);
                    break;
            }
        } while (choice != 0);

        scanner.close();
    }
}
