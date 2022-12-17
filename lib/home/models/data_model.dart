class DataModel {
  DataModel({
    required this.totalBoxInput,
    required this.totalSelectionAllowed,
    required this.alphabetsAllowed,
    required this.numbersAllowed,
    required this.resetValue,
    required this.success,
    required this.error,
    required this.maxAlphabetReachedError,
    required this.maxNumbersReachedError,
    required this.maxSelectionReachedError,
    required this.inputSelectionLimitError,
    required this.inputAlphabetsLimitError,
    required this.inputNumbersLimitError,
    required this.inputCheckboxLimitError,
    required this.alphabetList,
    required this.numberList,
  });

  final String totalBoxInput;
  final String totalSelectionAllowed;
  final String alphabetsAllowed;
  final String numbersAllowed;
  final String resetValue;
  final String success;
  final String error;
  final String maxAlphabetReachedError;
  final String maxNumbersReachedError;
  final String maxSelectionReachedError;
  final String inputSelectionLimitError;
  final String inputAlphabetsLimitError;
  final String inputNumbersLimitError;
  final String inputCheckboxLimitError;
  List<AlphabetModel> alphabetList;
  List<NumberModel> numberList;

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        totalBoxInput: json["total_box_input"],
        totalSelectionAllowed: json["total_selection_allowed"],
        alphabetsAllowed: json["alphabets_allowed"],
        numbersAllowed: json["numbers_allowed"],
        resetValue: json["reset_value"],
        success: json["success"],
        error: json["error"],
        maxAlphabetReachedError: json["max_alphabet_reached_error"],
        maxNumbersReachedError: json["max_numbers_reached_error"],
        maxSelectionReachedError: json["max_selection_reached_error"],
        inputSelectionLimitError: json["input_selection_limit_error"],
        inputAlphabetsLimitError: json["input_alphabets_limit_error"],
        inputNumbersLimitError: json["input_numbers_limit_error"],
        inputCheckboxLimitError: json["input_checkbox_limit_error"],
        alphabetList: List<AlphabetModel>.from(
            json["alphabet_list"].map((x) => AlphabetModel(title: x))),
        numberList: List<NumberModel>.from(
            json["number_list"].map((x) => NumberModel(title: x))),
      );

  Map<String, dynamic> toMap() => {
        "total_box_input": totalBoxInput,
        "total_selection_allowed": totalSelectionAllowed,
        "alphabets_allowed": alphabetsAllowed,
        "numbers_allowed": numbersAllowed,
        "reset_value": resetValue,
        "success": success,
        "error": error,
        "max_alphabet_reached_error": maxAlphabetReachedError,
        "max_numbers_reached_error": maxNumbersReachedError,
        "max_selection_reached_error": maxSelectionReachedError,
        "input_selection_limit_error": inputSelectionLimitError,
        "input_alphabets_limit_error": inputAlphabetsLimitError,
        "input_numbers_limit_error": inputNumbersLimitError,
        "inputCheckboxLimitError": inputCheckboxLimitError,
      };
}

class AlphabetModel {
  final String title;
  bool isSelected;
  AlphabetModel({required this.title, this.isSelected = false});
}

class NumberModel {
  final int title;
  bool isSelected;

  NumberModel({required this.title, this.isSelected = false});
}
