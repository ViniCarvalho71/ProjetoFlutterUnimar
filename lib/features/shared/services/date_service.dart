class DateService {
  static String formatarDataHora(String valor) {
    final texto = valor.trim();

    if (texto.isEmpty) {
      return '-';
    }

    final data = DateTime.tryParse(texto);

    if (data == null) {
      return texto;
    }

    final dataAjustada = data.isUtc ? data.toLocal() : data;

    return '${_doisDigitos(dataAjustada.day)}/' '${_doisDigitos(dataAjustada.month)}/''${dataAjustada.year} '
        '${_doisDigitos(dataAjustada.hour)}:' '${_doisDigitos(dataAjustada.minute)}:''${_doisDigitos(dataAjustada.second)}';
  }

  static String _doisDigitos(int valor) {
    return valor.toString().padLeft(2, '0');
  }
}
