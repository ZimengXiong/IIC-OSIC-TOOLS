#!/bin/bash
# SPDX-FileCopyrightText: 2024-2025 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
# SPDX-License-Identifier: Apache-2.0
#
# Test if the smoke test of OpenLane2 runs successfully; if this works,
# many SW packages have to work properly, so this is a test with good
# coverage.
#
# We do this only for sky130A for now.

RESULT=/tmp/result_ol_sky130a_vhdl.log
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Switch to sky130A PDK
# shellcheck source=/dev/null
source iic-pdk-script.sh sky130A sky130_fd_sc_hd > /dev/null
# Run the OpenLane2 smoke test
mkdir -p /tmp/ol2_sky130_vhdl
cp $DIR/counter.* /tmp/ol2_sky130_vhdl
openlane --flow VHDLClassic --manual-pdk /tmp/ol2_sky130_vhdl/counter.json > $RESULT
# Check if there is an error in the log
if grep -q "ERROR" "$RESULT"; then
    echo "[ERROR] Test <OpenLane using VHDL in sky130A> FAILED."
    exit 1
else
    echo "[INFO] Test <OpenLane using VHDL in sk130A> passed."
    exit 0
fi
