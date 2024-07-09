import 'package:json_annotation/json_annotation.dart';
part 'panelization_summary_vo.g.dart';

@JsonSerializable()
class PanelizationSummary{

    @JsonKey(name: "containsEpubBubbles")
    bool? containsEpubBubbles;

    @JsonKey(name: "containsImageBubbles")
    bool? containsImageBubbles;

    PanelizationSummary(this.containsEpubBubbles, this.containsImageBubbles);

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) => _$PanelizationSummaryFromJson(json);
    Map<String, dynamic> toJson() => _$PanelizationSummaryToJson(this);
}