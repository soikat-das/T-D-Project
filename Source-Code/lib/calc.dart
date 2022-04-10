import 'dart:ffi';
import 'dart:math';
import 'package:complex/complex.dart';
import 'package:complex/fastmath.dart';
import 'package:dart_numerics/dart_numerics.dart' as numerics;

extension Absolute on Complex {
  num abs() {
    return (this.real * this.real) + (this.imaginary * this.imaginary);
  }
}

num hypot(num x, num y) {
  var first = x.abs();
  var second = y.abs();

  if (y > x) {
    first = y.abs();
    second = x.abs();
  }

  if (first == 0.0) {
    return second;
  }

  final t = second / first;
  return first * sqrt(1 + t * t);
}

Complex complex_cosh(Complex number) {
  return Complex(
    cosh(number.real as double) * cos(number.imaginary),
    sinh(number.real as double) * sin(number.imaginary),
  );
}

Complex complex_sinh(Complex number) {
  return Complex(
    sinh(number.real as double) * cos(number.imaginary),
    cosh(number.real as double) * sin(number.imaginary),
  );
}

num i = pow(-1, 0.5);
const double e = 2.718281828459045;
const double pi = 3.1415926535897932;

List<num> polar(Complex z) {
  num a = z.real;
  num b = z.imaginary;

  num q = hypot(a, b);
  num theta = atan2(b as double, a as double);

  return <num>[q, theta];
}

double logBase(num x, num base) => log(x) / log(base);

num inductance(num xx, num yy) {
  return (2 * (pow(10, -4)) * logBase((xx / yy), e));
}

num capacitance(xx, yy) {
  return (((2 * 8.8541878128 * pi) * pow(10, -9)) / logBase((xx / yy), e));
}

Map<String, dynamic> calc(
    num? sys,
    num? d,
    num? s1,
    num? s2,
    num? s3,
    num? subConductors,
    num? spacing,
    num? strands,
    num? diameter,
    num? length,
    num? mode,
    num? res,
    num? freq,
    num? volt,
    num? load,
    num? pf) {
  num deq;

  if (sys == 1) {
    deq = 0;
  } else {
    deq = pow((s1! * s2! * s3!), (1 / 3));
  }

  spacing = spacing! * (pow(10, -2));
  num n = .5 + ((1 / 6) * (pow(((12 * strands!) - 3), (1 / 2))));

  num r1 = (((2 * n) - 1) * diameter!) * (pow(10, -3)) / 2;
  num r = (0.7788 * r1);
  num resistance = res! * length!;

  //INDUCTANCE & CAPACITANCE (output 1,2)
  num system = sys!;
  num l = 0, cap = 0, xl = 0, xc = 0;
  num sgm, sgmd;

  if (system == 1) {
    l = inductance(d!, r);
    cap = capacitance(d, r1);
    xl = 2 * pi * l * freq! * length;
    xc = 1 / (2 * pi * cap * freq * length);
  } else {
    if (subConductors == 2) {
      sgm = sqrt(r * spacing);
      sgmd = sqrt(r1 * spacing);
      l = inductance(deq, sgm);
      cap = capacitance(deq, sgmd);
      xl = 2 * pi * l * freq! * length;
      xc = 1 / (2 * pi * cap * freq * length);
    } else if (subConductors == 3) {
      sgm = pow((r * spacing * spacing), (1 / 3));
      sgmd = pow((r1 * spacing * spacing), (1 / 3));
      l = inductance(deq, sgm);
      cap = capacitance(deq, sgmd);
      xl = 2 * pi * l * freq! * length;
      xc = 1 / (2 * pi * cap * freq * length);
    } else if (subConductors == 4) {
      sgm = pow((r * 1.414 * spacing * spacing * spacing), 0.25);
      sgmd = pow((r1 * 1.414 * spacing * spacing * spacing), 0.25);
      l = inductance(deq, sgm);
      cap = capacitance(deq, sgmd);
      xl = 2 * pi * l * freq! * length;
      xc = 1 / (2 * pi * cap * freq * length);
    } else {
      sgm = pow(
          (6 * r * spacing * spacing * spacing * spacing * spacing), (1 / 6));
      sgmd = pow(
          (6 * r1 * spacing * spacing * spacing * spacing * spacing), (1 / 6));
      l = inductance(deq, sgm);
      cap = capacitance(deq, sgmd);
      xl = 2 * pi * l * freq! * length;
      xc = 1 / (2 * pi * cap * freq * length);
    }
  }

  // REACTANCE (output 3, 4)
  Complex z = Complex((resistance / 1000), (xl / 1000));
  Complex y = Complex(0, 1000 / xc);
  num ir = load! * 1000 / (pow(3, 0.5) * volt! * pf!);

  num ic;

  Complex aA1 = Complex(0, 0),
      bB1 = Complex(0, 0),
      cC1 = Complex(0, 0),
      dD1 = Complex(0, 0);
  num iSAbs = 0,
      vsAbs = 0,
      vreg = 0,
      ploss = 0,
      efficiency = 0,
      a1 = 0,
      a2 = 0,
      c1 = 0,
      c2 = 0,
      d1 = 0,
      d2 = 0,
      k = 0;

  num aaA1 = 0, ddD1 = 0, ccC1 = 0;

  if (mode == 1) {
    aaA1 = 1;
    ddD1 = 1;
    bB1 = z;
    ccC1 = 0;

    num a = aaA1.abs();
    num b = bB1.abs();
    num c = ccC1.abs();
    num d = ddD1.abs();
    ic = 0;
    //Complex vs = (aaA1 * volt) + (bbB1 * ir * pow(3, 0.5));
    Complex vs = bB1 * ir;
    vs = vs * pow(3, 0.5);
    vs += (aaA1 * volt);

    num iS = ir;
    vsAbs = vs.abs();
    iSAbs = iS.abs();
    vreg = ((vsAbs - volt) * 100) / volt;
    ploss = (3 * pow(ir, 2) * resistance) / pow(10, 6);
    efficiency = (load * 100) / (load + ploss);

    a1 = 0;
    a2 = atan(xl / resistance);
    c1 = ((-1) * (a / b) * pow(volt, 2) * (cos(a2 - a1)));
    c2 = ((d / b) * pow(vsAbs, 2) * (sin(a2 - a1)));
    d1 = ((d / b) * pow(vsAbs, 2) * (cos(a2 - a1)));
    d2 = ((d / b) * pow(vsAbs, 2) * (sin(a2 - a1)));

    k = (volt * vsAbs) / b;
  } else if (mode == 2) {
    //aA1 = dD1 = 1 + ((y * z) / 2)
    aA1 = ((y * z) / 2) + 1;
    dD1 = aA1;
    bB1 = z;
    cC1 = (((y * z) / 4) + 1) * y;
    num a = aA1.abs();
    num b = bB1.abs();
    num c = cC1.abs();
    num d = dD1.abs();
    Complex vs = (aA1 * volt) + (bB1 * ir * pow(3, 0.5));
    Complex iS = (cC1 * (volt / pow(3, .5))) + (dD1 * ir);
    vsAbs = vs.abs();
    iSAbs = iS.abs();

    ic = (volt + vsAbs) * 1000 / (2 * xc);
    num il = ir + (vsAbs / (xc * 2));
    num vx = vsAbs / a;
    vreg = ((vx - volt) * 100) / volt;
    ploss = (3 * pow(il, 2) * resistance) / pow(10, 6);
    efficiency = (load * 100) / (load + ploss);

    a1 = atan((y.abs() * xl) / (2 + (y.abs() * resistance)));
    a2 = atan(xl / resistance);
    c1 = ((-1) * (a / b) * pow(volt, 2) * (cos(a2 - a1)));
    c2 = ((1 / b) * pow(vsAbs, 2) * (sin(a2 - a1)));
    d1 = ((d / b) * pow(vsAbs, 2) * (cos(a2 - a1)));
    d2 = ((d / b) * pow(vsAbs, 2) * (sin(a2 - a1)));
    k = (volt * vsAbs) / b;
  } else {
    aA1 = complex_cosh((y * z).sqrt());
    dD1 = aA1;

    bB1 = (z / y).sqrt() * complex_sinh((y * z).sqrt());
    cC1 = (y / z).sqrt() * complex_sinh((y * z).sqrt());

    num aA = aA1.abs();
    num bB = bB1.abs();
    num cC = cC1.abs();
    num dD = dD1.abs();

    ic = cC * volt;
    Complex vs = (aA1 * volt) + (bB1 * ir * pow(3, 0.5));
    Complex iS = (cC1 * (volt / pow(3, .5))) + (dD1 * ir);
    vsAbs = vs.abs();
    iSAbs = iS.abs();
    num vx = vsAbs / aA;

    num vreg = ((vx - volt) * 100) / volt;
    num ploss = (3 * pow(iSAbs, 2) * resistance) / pow(10, 6);
    num efficiency = (load * 100) / (load + ploss);

    num l1 = sqrt(((z.abs() + resistance) * y.abs()) / 2);
    num l2 = sqrt((resistance - (z.abs()) * y.abs()) / 2);

    a1 = atan((tan(l2)) * (numerics.tanh(l1 as double)));
    a2 = atan((tan(l2)) / (numerics.tanh(l1)));
    c1 = ((-1) * (aA / bB) * (volt * 2) * (cos(a2 - a1)));
    c2 = ((dD / bB) * pow(vsAbs, 2) * (sin(a2 - a1)));
    d1 = ((dD / bB) * pow(vsAbs, 2) * (cos(a2 - a1)));
    d2 = ((dD / bB) * pow(vsAbs, 2) * (sin(a2 - a1)));
    k = (volt * vsAbs) / bB;
  }

  return {
    'L': l * pow(10, 3),
    'CAP': cap * pow(10, 8),
    'XL': xl,
    'XC': xc,
    'IC': ic,
    'A1': mode == 1 ? Complex(aaA1 + 0.0, 0.0) : polar(aA1),
    'B1': polar(bB1),
    'C1': mode == 1 ? Complex(ccC1 + 0.0, 0) : polar(cC1),
    'D1': mode == 1 ? Complex(ddD1 + 0.0, 0) : polar(dD1),
    'VS': vsAbs,
    'IS': iSAbs,
    'V_REG': vreg,
    'P_LOSS': ploss,
    'efficiency': efficiency,
    'send_center': <num>[d1, d2],
    'send_radius': k,
    'receive_center': <num>[c1, c2],
    'receive_radius': k,
  };
}
