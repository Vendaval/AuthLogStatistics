#include "GeoIP.h"
#include "GeoIPCity.h"

static const char *_mk_NA(const char *p)
{
    return p ? p : "N/A";
}

int main(int argc, char *argv[])
{
    FILE *f;
    GeoIP *gi;
    GeoIPRecord *gir;
    int generate = 0;
    char host[50];
    const char *time_zone = NULL;
    char **ret;
    if (argc == 2)
        if (!strcmp(argv[1], "gen"))
            generate = 1;

    gi = GeoIP_open("../data/GeoIPCity.dat", GEOIP_INDEX_CACHE);

    if (gi == NULL) {
        fprintf(stderr, "Error opening database\n");
        exit(1);
    }

    f = fopen("city_test.txt", "r");

    if (f == NULL) {
        fprintf(stderr, "Error opening city_test.txt\n");
        exit(1);
    }

    while (fscanf(f, "%s", host) != EOF) {
        gir = GeoIP_record_by_name(gi, (const char *)host);

        if (gir != NULL) {
            ret = GeoIP_range_by_ip(gi, (const char *)host);
            time_zone =
                GeoIP_time_zone_by_country_and_region(gir->country_code,
                                                      gir->region);
            printf("%s\t%s\t%s\t%s\t%s\t%s\t%f\t%f\t%d\t%d\t%s\t%s\t%s\n", host,
                   _mk_NA(gir->country_code), _mk_NA(gir->region),
                   _mk_NA(GeoIP_region_name_by_code
                          (gir->country_code, gir->region)), _mk_NA(gir->city),
                   _mk_NA(gir->postal_code), gir->latitude, gir->longitude,
                   gir->metro_code, gir->area_code, _mk_NA(time_zone), ret[0],
                   ret[1]);
            GeoIP_range_by_ip_delete(ret);
            GeoIPRecord_delete(gir);
        }
    }
    GeoIP_delete(gi);
    fclose(f);
    return 0;
}