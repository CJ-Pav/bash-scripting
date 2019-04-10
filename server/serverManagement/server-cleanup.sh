#!/bin/bash
 # consolidate storage and pav-x drive backups into master
 # clean restore folders and repopulate

/home/pav-admin/bin-server/server-management/pav-x_backup-consolidation.sh
/home/pav-admin/bin-server/server-management/pav-storage_backup-consolidation.sh
/home/pav-admin/bin-server/server-management/pav-x_migration.sh

echo "- Data sync..."
sync

echo "Cleanup complete."
