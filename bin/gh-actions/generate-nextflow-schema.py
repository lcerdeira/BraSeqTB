#! /usr/bin/env python3
"""

"""

PROGRAM = "generate-nextflow-schema.py"
VERSION = "3.0.0"
REPO = "braseqtb"

braseqtb_SCHEMA = "conf/schema/braseqtb.json"
JSON_SCHEMAS = [
    "modules/local/braseqtb/gather_samples/params.json",
    "modules/local/braseqtb/qc_reads/params.json",
    "modules/local/braseqtb/assemble_genome/params.json",
    "modules/local/braseqtb/assembly_qc/params.json",
    "modules/local/braseqtb/annotate_genome/params.json",
    "modules/local/braseqtb/call_variants/params.json",
    "modules/local/braseqtb/minmer_sketch/params.json",
    "modules/local/braseqtb/minmer_query/params.json",
    "modules/local/braseqtb/mapping_query/params.json",
    "modules/local/braseqtb/antimicrobial_resistance/params.json",
    "modules/local/braseqtb/sequence_type/params.json",
    "modules/local/braseqtb/blast/params.json",
    "conf/schema/generic.json"
]

if __name__ == '__main__':
    import argparse as ap
    import json
    import sys

    parser = ap.ArgumentParser(
        prog='generate-nextflow-schema.py',
        conflict_handler='resolve',
        description=(
            f'{PROGRAM} (v{VERSION}) - Merges existing schemas to make NF-Tower compatible schema'
        )
    )

    parser.add_argument('braseqtb', metavar="STR", type=str,
                        help='Directory containing braseqtb repository')
    parser.add_argument('--verbose', action='store_true',
                        help='Print debug related text.')
    parser.add_argument('--silent', action='store_true',
                        help='Only critical errors will be printed.')
    parser.add_argument('--version', action='version',
                        version=f'{PROGRAM} {VERSION}')

    if len(sys.argv) == 1:
        parser.print_help()
        sys.exit(0)

    args = parser.parse_args()

    # braseqtb main schema
    schema_data = None
    with open(f'{args.braseqtb}/{braseqtb_SCHEMA}', 'rt') as schema_fh:
        schema_data = json.load(schema_fh)

    # additional schemas
    for schema in JSON_SCHEMAS:
        with open(f'{args.braseqtb}/{schema}', 'rt') as schema_fh:
            json_data = json.load(schema_fh)
            for definition in json_data['definitions']:
                schema_data['definitions'][definition] = json_data['definitions'][definition]
                schema_data['allOf'].append({"$ref": f"#/definitions/{definition}"})

    print(json.dumps(schema_data, indent=4))
