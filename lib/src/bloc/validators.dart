import 'dart:async';

class Validators {

    final validarUsuario = StreamTransformer<String, String>.fromHandlers(
    handleData: ( usuario, sink) {

      Pattern pattern = r'^\D+$';
      RegExp regExp = new RegExp(pattern);

      if( regExp.hasMatch(usuario)) {
        sink.add(usuario);
      } else {
        sink.addError('Sólo letras y carácteres especiales.');
      }
    }
  );
  
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( password, sink) {
      if(password.length > 10){
        sink.add(password);
      } else {
        sink.addError('Más de 10 carácteres, por favor.');
      }
    }
  );

}