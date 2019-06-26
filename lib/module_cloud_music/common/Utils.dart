class Utils {
  static String toTenThousand(double val) {
    String tenThousand;
    if(val == null) return "";
    if(val > 10 * 1000) {
      tenThousand = "${(val / (10 * 1000)).floor()}万";
    }else {
      tenThousand = "$val";
    }
    
    return tenThousand; 
  }

}