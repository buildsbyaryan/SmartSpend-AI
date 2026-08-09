import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/expense_model.dart';

class PdfService {
  static Future<void> generateReport(List<Expense> expenses) async {
    final pdf = pw.Document();

    double total = 0;

    for (var e in expenses) {
      total += e.amount;
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        build: (context) => [

          pw.Text(
            "SmartSpend AI",
            style: pw.TextStyle(
              fontSize: 28,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Text(
            "Expense Report",
            style: pw.TextStyle(
              fontSize: 20,
            ),
          ),

          pw.Divider(),

          pw.SizedBox(height: 10),

          pw.Text(
            "Total Transactions : ${expenses.length}",
          ),

          pw.Text(
            "Total Expense : ₹${total.toStringAsFixed(2)}",
          ),

          pw.SizedBox(height: 20),

          pw.Table.fromTextArray(

            headers: const [
              "Title",
              "Category",
              "Amount",
              "Date",
            ],

            data: expenses.map((e) {

              return [

                e.title,

                e.category,

                "₹${e.amount}",

                "${e.date.day}/${e.date.month}/${e.date.year}",

              ];

            }).toList(),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}