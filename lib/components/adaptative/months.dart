class Months {
  static final Month JANEIRO = Month("Janeiro", "JAN", 1);
  static final Month FEVEREIRO = Month("Fevereiro", "FEV", 2);
  static final Month MARCO = Month("Março", "MAR", 3);
  static final Month ABRIL = Month("Abril", "ABR", 4);
  static final Month MAIO = Month("Maio", "MAI", 5);
  static final Month JUNHO = Month("Junho", "JUN", 6);
  static final Month JULHO = Month("Julho", "JUL", 7);
  static final Month AGOSTO = Month("Agosto", "AGO", 8);
  static final Month SETEMBRO = Month("Setembro", "SET", 9);
  static final Month OUTUBRO = Month("Outubro", "OUT", 10);
  static final Month NOVEMBRO = Month("Novembro", "NOV", 11);
  static final Month DEZEMBRO = Month("Dezembro", "DEZ", 12);

  static List<Month> getLast(int last) {
    var lastMonths = List<Month>.empty(growable: true);

    final actual = getActualMonth().id;

    for (int i = 0; i < last; i++) {
      var value = actual - i;
      final index = value > 0 ? value : 12 + value;

      lastMonths.add(getMonthById(index));
    }
    return lastMonths;
  }

  static List<Month> values() {
    return [
      JANEIRO,
      FEVEREIRO,
      MARCO,
      ABRIL,
      MAIO,
      JUNHO,
      JULHO,
      AGOSTO,
      SETEMBRO,
      OUTUBRO,
      NOVEMBRO,
      DEZEMBRO,
    ];
  }

  static Month getMonthById(int id) {
    return switch (id) {
      1 => JANEIRO,
      2 => FEVEREIRO,
      3 => MARCO,
      4 => ABRIL,
      5 => MAIO,
      6 => JUNHO,
      7 => JULHO,
      8 => AGOSTO,
      9 => SETEMBRO,
      10 => OUTUBRO,
      11 => NOVEMBRO,
      12 => DEZEMBRO,
      _ => JANEIRO
    };
  }

  static Month getActualMonth() {
    final date = DateTime.now();
    return Months.getMonthById(date.month);
  }
}

class Month {
  final String month;
  final String monthShort;
  final int id;

  Month(this.month, this.monthShort, this.id);
}
