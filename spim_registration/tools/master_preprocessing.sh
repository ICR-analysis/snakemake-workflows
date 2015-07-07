#!/bin/bash
#===============================================================================
#
#	  FILE: master_preprocessing.sh
#
#  DESCRIPTION: source file for pre-processing of file formats
#
#       AUTHOR: Christopher Schmied, schmied@mpi-cbg.de
#    INSTITUTE: Max Planck Institute for Molecular Cell Biology and Genetics
#         BUGS:
#        NOTES:
#      Version: 1.0
#      CREATED: 2015-07-05
#     REVISION: 2015-07-05
#
# Preprocessing
#	1) rename .czi files
#	2) resave .czi files into .tif or .zip
#	3) resave ome.tiff files into .tif
#	4) Splitting output for Channel is
#		c=0,1 etc
#		spim_TL{tt}_Angle{a}_Channel{c}.tif
#===============================================================================
image_file_directory="/projects/pilot_spim/Christopher/Test_pipeline_3.0/czi/"

# --- jobs directory -----------------------------------------------------------
job_directory="/projects/pilot_spim/Christopher/snakemake-workflows/spim_registration/tools/"
#-------------------------------------------------------------------------------
# Resaving, Renaming files and Splitting: General
#
# Important: For renaming and resaving .czi files the first .czi file has to
# carry the index (0)
#-------------------------------------------------------------------------------

pad="3"		# for padded zeros
angle_prep="1" # angles format: "1 2 3"

#--- Renaming ------------------------------------------------------------------

first_index="0"		# First index of czi files
last_index="391"		# Last index of czi files
first_timepoint="0"	# Starts with 0
angles_renaming=(1 2 3 4 5)	# Angles format: (1 2 3)

source_pattern=2014-10-23_H2A_gsb_G3\(\{index\}\).czi # Name of .czi files
target_pattern=spim_TL\{timepoint\}_Angle\{angle\}.czi	# The output pattern of renaming

#-------------------------------------------------------------------------------
# Fiji settings
#-------------------------------------------------------------------------------
XVFB_RUN="/sw/bin/xvfb-run" # virtual frame buffer

Fiji_resave="/sw/users/schmied/lifeline/Fiji.app.lifeline2/ImageJ-linux64" # Fiji that works for resaving
#-------------------------------------------------------------------------------
# Pre-processing
#-------------------------------------------------------------------------------
#--- Resaving .czi into .tif files----------------------------------------------
jobs_resaving=${job_directory}"czi_resave"  	# directory .czi resaving
resaving=${jobs_resaving}"/resaving.bsh" 	# script .czi resaving
#--- Resaving ome.tiff into .tif files -----------------------------------------
jobs_resaving_ometiff=${job_directory}"ometiff_resave" 	 # directory .ome.tiff resaving
resaving_ometiff=${jobs_resaving_ometiff}"/resaving-ometiff.bsh" # script .ome.tiff resaving
#--- Compress dataset;----------------------------------------------------------
jobs_compress=${job_directory}"compress" 	# directory .czi to .zip resaving
czi_compress=${jobs_compress}"/for_czi.bsh" 	# script .czi to .zip resaving
#--- Split channels-------------------------------------------------------------
jobs_split=${job_directory}"split_channels" 			# directory
split=${jobs_split}"/split.bsh" 				# script