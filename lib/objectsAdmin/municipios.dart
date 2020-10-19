import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Municipios {
  String altitud,
      cabecera,
      claveIGECEM,
      clima,
      cuerposAgua,
      elevaciones,
      latitud,
      longitud,
      masExtensos,
      masIndustrializados,
      masPoblados,
      menosExtensos,
      municipio,
      rios,
      significado,
      superficie;

  Municipios(
      this.altitud,
      this.cabecera,
      this.claveIGECEM,
      this.clima,
      this.cuerposAgua,
      this.elevaciones,
      this.latitud,
      this.longitud,
      this.masExtensos,
      this.masIndustrializados,
      this.masPoblados,
      this.menosExtensos,
      this.municipio,
      this.rios,
      this.significado,
      this.superficie);
}
