

import 'package:flutter/material.dart';

class StartMarkerPainter extends CustomPainter {

  final int minutes;
  final String destination;

  StartMarkerPainter({
    required this.minutes, 
    required this.destination
  });

  
  @override
  void paint(Canvas canvas, Size size) {
    
    final blackPaint = Paint()
                        ..color = Colors.black;
    
    final whitePaint = Paint()
                        ..color = Colors.white;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Circulo Negro
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height - circleBlackRadius ) , 
      circleBlackRadius, 
      blackPaint);

    // Circulo Blanco
    canvas.drawCircle(
      Offset( circleBlackRadius, size.height - circleBlackRadius ) , 
      circleWhiteRadius, 
      whitePaint );

    
    // Dibujar caja blanca
    final path = Path();
    path.moveTo( 40, 20 );
    path.lineTo(size.width - 10, 20 );
    path.lineTo(size.width - 10, 100 );
    path.lineTo( 40, 100 );

    // Sombra
    canvas.drawShadow(path, Colors.black, 10, false );

    // Caja
    canvas.drawPath(path, whitePaint );

    // Caja Negra
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(blackBox, blackPaint );

    // Textos
    // Minutos
    final textSpan = TextSpan(
      style: const TextStyle( color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400 ),
      text: '$minutes'
    );

    final minutesPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesPainter.paint(canvas, const Offset( 40, 35 ));


    // Palabra MIN
    const minutesText = TextSpan(
      style: TextStyle( color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300 ),
      text: 'Min'
    );

    final minutesMinPainter = TextPainter(
      text: minutesText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      minWidth: 70,
      maxWidth: 70
    );

    minutesMinPainter.paint(canvas, const Offset( 40, 68 ));


    // Descripción

    final locationText = TextSpan(
      style: const TextStyle( color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300 ),
      text: destination
    );

    final locationPainter = TextPainter(
      maxLines: 2,
      ellipsis: '...',
      text: locationText,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left
    )..layout(
      minWidth: size.width - 135,
      maxWidth: size.width - 135
    );

    final double offsetY = ( destination.length > 20 ) ? 35 : 48;

    locationPainter.paint(canvas, Offset( 120, offsetY ));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

}