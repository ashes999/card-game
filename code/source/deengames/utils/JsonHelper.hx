package deengames.utils;

class JsonHelper {
  // Copy fields from a JSON source to some class instance (target).
  public static function copy(source : Dynamic, target : Dynamic) : Dynamic
  {
    for(field in Reflect.fields(source)) {
      Reflect.setField(target, field, Reflect.field(source, field));
    }

    // Not necessary but lets us easily create/push target to an array
    return target;
  }
}
