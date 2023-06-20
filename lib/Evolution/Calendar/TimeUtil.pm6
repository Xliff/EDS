use v6.c;

use GLib::Raw::Traits;
use Evolution::Raw::Types;
use Evolution::Raw::Calendar::TimeUtil;

role Evolution::Roles::Extends::ICalTime {

  method e_cal_util_icaltime_to_tm {
    e_cal_util_icaltime_to_tm(self.ICalTime);
  }

  method e_cal_util_icaltime_to_tm_with_zone (
    ICalTimezone() $from_zone,
    ICalTimezone() $to_zone
  ) {
    e_cal_util_icaltime_to_tm_with_zone(
      self.ICalTime,
      $from_zone,
      $to_zone
    );
  }

  method new_from_tm (
    tm    $tm,
    Int() $is_date
  ) {
    self.tm_to_icaltime($tm, $is_date);
  }
  method tm_to_icaltime (
    tm     $tm,
    Int()  $is_date,
          :$raw      = False
  )
    is static
  {
    my gboolean $i = $is_date;

    propReturnObject(
      e_cal_util_tm_to_icaltime($tm, $is_date);
      $raw,
      |self.getTypePair
    );
  }


}

class Evolution::Calendar::TimeUtils::Static {
  also does GLib::Roles::StaticClass;

  method isodate_from_time_t (Int() $time) {
    my time_t $t = $time;

    isodate_from_time_t($t);
  }

  method add_day (Int() $time, Int() $days) {
    my time_t $t = $time;
    my gint   $d = $days;

    time_add_day($t, $d);
  }

  method add_day_with_zone (
    Int()        $time,
    Int()        $days,
    ICalTimezone $zone
  ) {
    my time_t $t = $time;
    my gint   $d = $days;

    time_add_day_with_zone($t, $d, $zone);
  }

  method add_month_with_zone (
    Int()          $time,
    Int()          $months,
    ICalTimezone() $zone
  ) {
    my time_t $t = $time;
    my gint   $m = $months;

    time_add_month_with_zone($t, $m, $zone);
  }

  method add_week (Int() $time, Int() $weeks) {
    my time_t $t = $time;
    my gint   $w = $weeks;

    time_add_week($t, $w);
  }

  method add_week_with_zone (
    Int()        $time,
    Int()        $weeks,
    ICalTimezone $zone;
  ) {
    my time_t $t = $time;
    my gint   $w = $weeks;

    time_add_week_with_zone($t, $w, $zone);
  }

  method day_begin (Int() $time) {
    my time_t $t = $time;

    time_day_begin($t);
  }

  method day_begin_with_zone (Int() $time, ICalTimezone() $zone) {
    my time_t $t = $time;

    time_day_begin_with_zone($t, $zone);
  }

  method day_end (Int() $time) {
    my time_t $t = $time;

    time_day_end($t);
  }

  method day_end_with_zone (Int() $time, ICalTimezone() $zone) {
    my time_t $t = $time;

    time_day_end_with_zone($t, $zone);
  }

  method day_of_week (Int() $day, Int() $month, Int() $year) {
    my gint ($y, $m, $d) = ($year, $month, $day);

    time_day_of_week($d, $m, $y);
  }

  method day_of_year (Int() $day, Int() $month, Int() $year) {
    my gint ($y, $m, $d) = ($year, $month, $day);

    time_day_of_year($d, $m, $y);
  }

  method days_in_month (Int() $year, Int() $month) {
    my gint ($y, $m) = ($year, $month);

    time_days_in_month($y, $m);
  }

  method from_isodate (Str() $str) {
    time_from_isodate($str);
  }

  method is_leap_year ($year) {
    my gint $y = $year;

    time_is_leap_year($y);
  }

  method leap_years_up_to (Int() $year) {
    my gint $y = $year;

    time_leap_years_up_to($y);
  }

  method month_begin_with_zone (
    Int()          $time,
    ICalTimezone() $zone
  ) {
    my time_t $t = $time;

    time_month_begin_with_zone($t, $zone);
  }

  method  to_gdate_with_zone (
    GDate()        $date,
    Int()          $time,
    ICalTimezone() $zone
  ) {
    my time_t $t = $time;

    time_to_gdate_with_zone($date, $t, $zone);
  }

  method week_begin_with_zone (
    Int()          $time,
    Int()          $week_start_day,
    ICalTimezone() $zone
  ) {
    my time_t $t = $time;
    my gint   $w = $week_start_day;

    time_week_begin_with_zone($t, $w, $zone);
  }

  method year_begin_with_zone (
    Int()          $time,
    ICalTimezone() $zone
  ) {
    my time_t $t = $time;

    time_year_begin_with_zone($t, $zone);
  }

}

constant TimeUtilS is export = Evolution::Calendar::TimeUtils::Static;

# BOXED

class Evolution::Calendar::TimeUtil {
  has time_t $!t is implementor;

  submethod BUILD ( :$time ) {
    $!t = $time if $time;
  }

  method new (Int() $time) {
    return Nil without $time;

    self.bless( :$time );
  }

  method to_isodate {
    my $time = TimeUtilS.isodate_from_time_t($!t);

    self.bless( :$time );
  }

  method add_day (Int() $days) {
    my gint $d = $days;

    my $time = TimeUtilS.add_day($!t, $d);

    self.bless( :$time );
  }

  method add_day_with_zone (Int() $days, ICalTimezone() $zone) {
    my gint $d = $days;

    my $time = TimeUtilS.add_day_with_zone($!t, $d, $zone);

    self.bless( :$time );
  }

  method add_month_with_zone (Int() $months, ICalTimezone() $zone) {
    my gint $m = $months;

    my $time = TimeUtilS.add_month_with_zone($!t, $m, $zone);

    self.bless( :$time );
  }

  method add_week (Int() $weeks) {
    my gint $w = $weeks;

    my $time = TimeUtilS.add_week($!t, $w);

    self.bless( :$time );
  }

  method add_week_with_zone (Int() $weeks, ICalTimezone() $zone) {
    my gint $w = $weeks;

    my $time = TimeUtilS.add_week_with_zone($!t, $w, $zone);

    self.bless( :$time );
  }

  method day_begin {
    my $time = TimeUtilS.day_begin($!t);

    self.bless( :$time );
  }

  method day_begin_with_zone(ICalTimezone() $zone) {
    my $time = TimeUtilS.day_begin_with_zone($!t, $zone);

    self.bless( :$time );
  }

  method day_end {
    my $time = TimeUtilS.day_end($!t);

    self.bless( :$time );
  }

  method day_end_with_zone (ICalTimezone() $zone) {
    my $time = TimeUtilS.day_end_with_zone($!t, $zone);

    self.bless( :$time );
  }

  method month_begin_with_zone (ICalTimezone() $zone) {
    my $time = TimeUtilS.month_begin_with_zone($!t, $zone);

    self.bless( :$time );
  }

  method to_gdate_with_zone (ICalTimezone() $zone) {
    my $gd = GLib::Date.new;

    TimeUtilS.to_gdate_with_zone($gd, $!t, $zone);
    $gd;
  }

  method week_begin_with_zone (Int() $week_start_day, ICalTimezone() $zone) {
    my $time = TimeUtilS.week_begin_with_zone($!t, $week_start_day, $zone);

    self.bless( :$time );
  }

  method year_begin_with_zone (ICalTimezone() $zone) {
    my $time = TimeUtilS.year_begin_with_zone($!t, $zone);

    self.bless( :$time );
  }

}
