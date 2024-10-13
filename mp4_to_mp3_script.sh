#!/bin/bash

# Logo de música en caracteres (Símbolo musical grande)
echo "♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬"
echo "       MP4 to MP3 Converter       "
echo "♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬"

# Contar la cantidad de archivos MP4 en el directorio actual
file_count=$(ls *.mp4 2>/dev/null | wc -l)

if [ "$file_count" -eq 0 ]; then
    echo "No se encontraron archivos MP4 para convertir en el directorio actual."
    exit 1
fi

echo "Archivos a convertir: $file_count"
echo "-----------------------------------------"

# Inicializar una lista para las canciones convertidas
converted_songs=()

# Convertir todos los archivos MP4 en el directorio actual
for input_file in *.mp4; do
    # Obtener el nombre base del archivo sin la extensión .mp4
    output_file="${input_file%.mp4}.mp3"
    
    # Mostrar el archivo que se está convirtiendo
    echo "Convirtiendo: $input_file"
    
    # Si el archivo MP3 ya existe, eliminarlo para permitir la sobrescritura
    if [ -f "$output_file" ]; then
        echo "El archivo $output_file ya existe. Sobrescribiendo..."
        rm "$output_file"
    fi
    
    # Realizar la conversión y ocultar la salida de ffmpeg
    ffmpeg -loglevel error -i "$input_file" -q:a 0 -map a "$output_file"
    
    # Verificar si la conversión fue exitosa
    if [ $? -eq 0 ]; then
        echo "Conversión exitosa: $input_file -> $output_file"
        rm "$input_file"
        echo "Archivo MP4 eliminado: $input_file"
        
        # Agregar la canción convertida a la lista
        converted_songs+=("$output_file")
    else
        echo "Error: La conversión falló para $input_file"
    fi
done

# Mostrar la lista de canciones convertidas al final
echo "-----------------------------------------"
echo "Canciones convertidas:"
for song in "${converted_songs[@]}"; do
    echo "$song"
done

# Despedida con logo
echo "♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬"
echo "      ¡Disfruta tu música!       "
echo "♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬♬"
