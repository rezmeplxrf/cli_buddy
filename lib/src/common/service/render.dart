import 'package:barbecue/barbecue.dart';
import 'package:cli_buddy/src/common/domain/session.dart';

class RenderService {
  static String sessionsList(List<ChatSession> sessions) {
    final rows = sessions.map((session) {
      return Row(cells: [
        Cell(
          session.id.toString(),
        ),
        Cell(
          session.messages.length.toString(),
        ),
        Cell(session.model ?? 'Unknown')
      ]);
    }).toList();

    final table = Table(
      cellStyle: const CellStyle(
        paddingRight: 2,
        paddingLeft: 2,
      ),
      tableStyle: const TableStyle(border: true),
      header: const TableSection(rows: [
        Row(
          cells: [
            Cell('ID'),
            Cell('Msgs'),
            Cell('Model'),
          ],
          cellStyle: CellStyle(borderBottom: true),
        ),
      ]),
      body: TableSection(
        cellStyle: const CellStyle(
            paddingRight: 2,
            alignment: TextAlignment.MiddleLeft,
            borderBottom: true),
        rows: rows,
      ),
    ).render();

    return table;
  }

  static String messages(ChatSession session) {
    final rows = session.messages.map((message) {
      return Row(cells: [
        Cell(
          message.role.name,
        ),
        Cell(
          DateTime.fromMillisecondsSinceEpoch(message.timestamp)
              .toIso8601String(),
        ),
        Cell(
          message.content,
        ),
        Cell(
          message.usage?.totalTokens?.toString() ?? '',
        ),
      ]);
    }).toList();
// TODO: when content is long, the table gets messy
    final table = Table(
      cellStyle: const CellStyle(
          paddingRight: 1,
          paddingLeft: 1,
          borderBottom: true,
          borderLeft: true,
          alignment: TextAlignment.MiddleCenter),
      tableStyle: const TableStyle(
        border: true,
      ),
      header: const TableSection(rows: [
        Row(
          cells: [
            Cell('Role'),
            Cell('Date'),
            Cell('Content'),
            Cell('Token'),
          ],
          cellStyle: CellStyle(borderBottom: true),
        ),
      ]),
      body: TableSection(
        cellStyle: const CellStyle(paddingRight: 2),
        rows: rows,
      ),
    ).render();

    return table;
  }
}
