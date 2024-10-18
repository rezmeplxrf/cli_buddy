import 'dart:convert';

import 'package:barbecue/barbecue.dart';
import '../../../cli_buddy.dart';
import '../models/config.dart';
import 'package:mason_logger/mason_logger.dart';

class RenderService {
  static String sessionList(List<ChatSession> sessions) {
    final rows = sessions.map((session) {
      return Row(cells: [
        Cell(
          session.id.toString(),
        ),
        Cell(
          session.messages.length.toString(),
        ),
        Cell(session.modelId)
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

    return '\n$table\n';
  }

  static String messageList(ChatSession session) {
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
    final table = Table(
      cellStyle: const CellStyle(
        paddingRight: 1,
        paddingLeft: 1,
        borderBottom: true,
        borderLeft: true,
      ),
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
          cellStyle: CellStyle(
              borderBottom: true, alignment: TextAlignment.MiddleCenter),
        ),
      ]),
      body: TableSection(
        cellStyle: const CellStyle(
            paddingRight: 2, alignment: TextAlignment.MiddleCenter),
        rows: rows,
      ),
    ).render();

    return '\n$table\n';
  }

  static String creditInfo(ORCredit credits) {
    final rows = [
      Row(cells: [
        const Cell('Label'),
        Cell(credits.label ?? 'N/A'),
      ]),
      Row(cells: [
        const Cell('Limit'),
        Cell(credits.limit?.toString() ?? 'N/A'),
      ]),
      Row(cells: [
        const Cell('Usage'),
        Cell(credits.usage?.toString() ?? 'N/A'),
      ]),
      Row(cells: [
        const Cell('Limit Remaining'),
        Cell(credits.limitRemaining?.toString() ?? 'N/A'),
      ]),
      Row(cells: [
        const Cell('Is Free Tier'),
        Cell(credits.isFreeTier?.toString() ?? 'N/A'),
      ]),
      if (credits.rateLimit != null) ...[
        Row(cells: [
          const Cell('Rate Limit Requests'),
          Cell(credits.rateLimit!.requests?.toString() ?? 'N/A'),
        ]),
        Row(cells: [
          const Cell('Rate Limit Interval'),
          Cell(credits.rateLimit!.interval ?? 'N/A'),
        ]),
      ],
    ];

    final table = Table(
      cellStyle: const CellStyle(
        paddingRight: 2,
        paddingLeft: 2,
        borderLeft: true,
      ),
      tableStyle: const TableStyle(border: true),
      body: TableSection(
        cellStyle: const CellStyle(
            paddingRight: 2,
            alignment: TextAlignment.MiddleLeft,
            borderBottom: true),
        rows: rows,
      ),
    ).render();

    return '\n$table\n';
  }

  static String _formatContextLength(int? contextLength) {
    if (contextLength == null) {
      return 'N/A';
    }

    if (contextLength >= 1000000) {
      return '${_roundToThreeDigits(contextLength / 1000000)}m';
    } else if (contextLength >= 1000) {
      return '${_roundToThreeDigits(contextLength / 1000)}k';
    } else {
      return contextLength.toString();
    }
  }

  static double _roundToThreeDigits(double value) {
    return (value * 1000).ceil() / 1000;
  }

  static String modelList(List<ORModel> models) {
    final rows = models.map((model) {
      final promptPricing =
          double.tryParse(model.pricing?.prompt?.toString() ?? '');
      final promptPerMillion = promptPricing != null
          ? _roundToThreeDigits(promptPricing * 1000000)
          : 'N/A';
      final completionPricing =
          double.tryParse(model.pricing?.completion?.toString() ?? '');
      final completionPerMillion = completionPricing != null
          ? _roundToThreeDigits(completionPricing * 1000000)
          : 'N/A';
      final imagePricing =
          double.tryParse(model.pricing?.image?.toString() ?? '');
      final imagePerMillion = (imagePricing != null && imagePricing > 0)
          ? _roundToThreeDigits(imagePricing * 1000000)
          : 'N/A';

      return Row(cells: [
        Cell(model.id),
        Cell(_formatContextLength(model.contextLength)),
        Cell(promptPerMillion.toString()),
        Cell(completionPerMillion.toString()),
        Cell(imagePerMillion.toString()),
      ]);
    }).toList();

    final table = Table(
      cellStyle: const CellStyle(
          paddingLeft: 1,
          paddingRight: 1,
          borderLeft: true,
          alignment: TextAlignment.MiddleLeft),
      tableStyle: const TableStyle(
        border: true,
      ),
      header: const TableSection(rows: [
        Row(
          cells: [
            Cell('ID'),
            Cell('Context'),
            Cell('Prompt'),
            Cell('Completion'),
            Cell('Image'),
          ],
          cellStyle: CellStyle(
              borderBottom: true, alignment: TextAlignment.MiddleLeft),
        ),
      ]),
      body: TableSection(
        cellStyle: const CellStyle(
            alignment: TextAlignment.MiddleLeft, borderBottom: true),
        rows: rows,
      ),
    ).render();

    return '\n$table\n${yellow.wrap('* all prices (prompt, completion, image) are per million tokens in USD')}\n${lightGreen.wrap('* Total Models: ${models.length}')}\n';
  }

  static String parameterInfoTable({required ParameterInfo parameter}) {
    // Create rows for the first table (properties and their values)
    final propertyRows = [
      Row(cells: [
        const Cell('Frequency Penalty P10'),
        Cell(parameter.frequencyPenaltyP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Frequency Penalty P50'),
        Cell(parameter.frequencyPenaltyP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Frequency Penalty P90'),
        Cell(parameter.frequencyPenaltyP90?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Min P P10'),
        Cell(parameter.minPP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Min P P50'),
        Cell(parameter.minPP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Min P P90'),
        Cell(parameter.minPP90?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Presence Penalty P10'),
        Cell(parameter.presencePenaltyP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Presence Penalty P50'),
        Cell(parameter.presencePenaltyP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Presence Penalty P90'),
        Cell(parameter.presencePenaltyP90?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Repetition Penalty P10'),
        Cell(parameter.repetitionPenaltyP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Repetition Penalty P50'),
        Cell(parameter.repetitionPenaltyP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Repetition Penalty P90'),
        Cell(parameter.repetitionPenaltyP90?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Temperature P10'),
        Cell(parameter.temperatureP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Temperature P50'),
        Cell(parameter.temperatureP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Temperature P90'),
        Cell(parameter.temperatureP90?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top A P10'),
        Cell(parameter.topAP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top A P50'),
        Cell(parameter.topAP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top A P90'),
        Cell(parameter.topAP90?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top K P10'),
        Cell(parameter.topKP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top K P50'),
        Cell(parameter.topKP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top K P90'),
        Cell(parameter.topKP90?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top P P10'),
        Cell(parameter.topPP10?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top P P50'),
        Cell(parameter.topPP50?.toString() ?? 'N/A')
      ]),
      Row(cells: [
        const Cell('Top P P90'),
        Cell(parameter.topPP90?.toString() ?? 'N/A')
      ]),
    ];

    final propertyTable = Table(
      cellStyle:
          const CellStyle(paddingRight: 1, paddingLeft: 1, borderLeft: true),
      tableStyle: const TableStyle(border: true),
      header: const TableSection(rows: [
        Row(
          cells: [
            Cell('Default Property'),
            Cell('Value'),
          ],
          cellStyle: CellStyle(borderBottom: true),
        ),
      ]),
      body: TableSection(
        cellStyle: const CellStyle(
            alignment: TextAlignment.MiddleLeft, borderBottom: true),
        rows: propertyRows,
      ),
    ).render();

    final supportedParametersRows = parameter.supportedParameters
            ?.map((param) => Row(cells: [Cell(param)]))
            .toList() ??
        [
          const Row(cells: [Cell('N/A')])
        ];

    // Create the second table
    final supportedParametersTable = Table(
      cellStyle: const CellStyle(
        paddingRight: 2,
        paddingLeft: 2,
      ),
      tableStyle: const TableStyle(border: true),
      header: const TableSection(rows: [
        Row(
          cells: [
            Cell('Supported Parameters'),
          ],
          cellStyle: CellStyle(borderBottom: true),
        ),
      ]),
      body: TableSection(
        cellStyle: const CellStyle(
            paddingRight: 2,
            alignment: TextAlignment.MiddleLeft,
            borderBottom: true),
        rows: supportedParametersRows,
      ),
    ).render();

    return '${cyan.wrap(parameter.model)}\n\n$propertyTable\n\n$supportedParametersTable\n';
  }

  static String configurationJson(Configuration config) {
   final jsonEncoded = jsonEncode(config.toJson());

 
    return '\n$jsonEncoded\n';
  }
}
